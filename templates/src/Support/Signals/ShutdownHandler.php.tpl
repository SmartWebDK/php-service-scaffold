<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Support\Signals;

use Psr\Log\LoggerInterface;
use {{.Data.namespace}}\Service\ServiceInterface;

/**
 * Signal handler that shuts down a service.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class ShutdownHandler implements SignalHandlerInterface
{
    
    /**
     * @var LoggerInterface
     */
    private $logger;
    
    /**
     * @var ServiceInterface
     */
    private $service;
    
    /**
     * @param LoggerInterface  $logger
     * @param ServiceInterface $service
     */
    public function __construct(LoggerInterface $logger, ServiceInterface $service)
    {
        $this->logger = $logger;
        $this->service = $service;
    }
    
    /**
     * @param int        $signal
     * @param array|null $info
     */
    public function handle(int $signal, ?array $info = null) : void
    {
        $this->service->setActive(false);
        $this->logger->info("Received signal: {$signal}");
        $this->logger->info('Shutting down...');
        
        exit(1);
    }
    
    /**
     * Signals accepted by this handler.
     *
     * @return int[]
     */
    public function signals() : array
    {
        return [
            \SIGINT,
            \SIGTERM,
        ];
    }
}
