<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Console\Commands;

use Illuminate\Console\Command;
use Psr\Log\LoggerInterface;
use SmartWeb\Webhooks\Service\ServiceInterface;

/**
 * Boot and run the service.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class RunCommand extends Command
{
    
    /**
     * @var ServiceInterface
     */
    private $service;
    
    /**
     * @var LoggerInterface
     */
    private $logger;
    
    /**
     * @param ServiceInterface $service
     * @param LoggerInterface  $logger
     */
    public function __construct(ServiceInterface $service, LoggerInterface $logger)
    {
        parent::__construct();
        
        $this->service = $service;
        $this->logger = $logger;
        
        $this->setName('run');
        $this->setDescription('Boot and run the service.');
    }
    
    /**
     * Execute the console command.
     *
     * @return int|null
     */
    public function handle() : ?int
    {
        $this->logger->info('Running service...');
        $this->service->run();
        
        return 0;
    }
}
