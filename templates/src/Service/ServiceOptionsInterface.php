<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Service;

use NatsStreaming\Connection;
use Psr\Log\LoggerInterface;

/**
 * Interface for classes that describe a collection of options for a service.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
interface ServiceOptionsInterface
{
    
    /**
     * Get the connection to be used.
     *
     * @return Connection
     */
    public function getConnection() : Connection;
    
    /**
     * Get the logger to be used.
     *
     * @return LoggerInterface
     */
    public function getLogger() : LoggerInterface;
}
