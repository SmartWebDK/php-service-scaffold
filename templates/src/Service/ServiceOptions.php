<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Service;

use NatsStreaming\Connection;
use Psr\Log\LoggerInterface;

/**
 * Options for a service.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class ServiceOptions implements ServiceOptionsInterface
{
    
    /**
     * @var Connection
     */
    private $connection;
    
    /**
     * @var LoggerInterface
     */
    private $logger;
    
    /**
     * @param Connection      $connection
     * @param LoggerInterface $logger
     */
    public function __construct(Connection $connection, LoggerInterface $logger)
    {
        $this->connection = $connection;
        $this->logger = $logger;
    }
    
    /**
     * Get the connection to be used.
     *
     * @return Connection
     */
    public function getConnection() : Connection
    {
        return $this->connection;
    }
    
    /**
     * Get the logger to be used.
     *
     * @return LoggerInterface
     */
    public function getLogger() : LoggerInterface
    {
        return $this->logger;
    }
}
