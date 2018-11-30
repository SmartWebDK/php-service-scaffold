<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Service;

use NatsStreaming\Exceptions\ConnectException;
use NatsStreaming\Exceptions\TimeoutException;
use SmartWeb\Util\PathUtil;
use {{.Data.namespace}}\Support\Signals\ShutdownHandler;
use {{.Data.namespace}}\Support\Signals\Signals;

/**
 * Base class for services.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class BaseService implements ServiceInterface
{
    
    /**
     * @var bool
     */
    private $active = false;
    
    /**
     * @var string
     */
    private $name;
    
    /**
     * @var string
     */
    private $eventNamespace;
    
    /**
     * @var string
     */
    private $version;
    
    /**
     * @var ServiceOptionsInterface
     */
    private $options;
    
    /**
     * @param string                  $name           Fully-qualified name of this service.
     * @param string                  $eventNamespace Namespace of events used by this service.
     * @param string                  $version        Version of this service.
     * @param ServiceOptionsInterface $options
     */
    public function __construct(string $name, string $eventNamespace, string $version, ServiceOptionsInterface $options)
    {
        $this->name = $name;
        $this->eventNamespace = $eventNamespace;
        $this->version = $version;
        $this->options = $options;
    }
    
    /**
     * @return ServiceOptionsInterface
     */
    final protected function getOptions() : ServiceOptionsInterface
    {
        return $this->options;
    }
    
    /**
     * Get the fully-qualified name of this service.
     *
     * @return string
     */
    final public function getName() : string
    {
        return $this->name;
    }
    
    /**
     * Get the namespace used for events originating from this service.
     *
     * @return string
     */
    final public function getEventNamespace() : string
    {
        return $this->eventNamespace;
    }
    
    /**
     * Get the version string of this service.
     * **MUST** return a version string formatted according to Semantic Versioning 2.0.0.
     *
     * @link https://semver.org/ For details on the format and meaning of valid version strings.
     *
     * @return string
     */
    final public function getVersion() : string
    {
        return $this->version;
    }
    
    /**
     * Run this service.
     */
    final public function run() : void
    {
        $this->boot();
        
        try {
            $this->connect();
            
            // Start the service execution flow.
            $this->doRun();
            
            $this->disconnect();
        } catch (\Exception $error) {
            $this->options->getLogger()->error($error);
        }
    }
    
    private function boot() : void
    {
        $this->registerSignalHandlers();
        
        $this->setActive(true);
    }
    
    private function registerSignalHandlers() : void
    {
        Signals::enableAsync();
        $handler = new ShutdownHandler($this->options->getLogger(), $this);
        Signals::setHandler(\SIGINT, $handler);
        Signals::setHandler(\SIGTERM, $handler);
    }
    
    /**
     * The main execution flow of the service.
     */
    private function doRun() : void
    {
        $this->init();
        
        while ($this->isActive()) {
            $this->execute();
        }
    }
    
    /**
     * Initialize the service.
     */
    protected function init() : void
    {
    
    }
    
    /**
     * The main execution loop of the service.
     */
    protected function execute() : void
    {
        $this->options->getConnection()->wait();
    }
    
    /**
     * @throws ConnectException Thrown when the service was unable to connect to the NATS server.
     * @throws TimeoutException Thrown when a timeout occurred while connection to the NATS server.
     */
    private function connect() : void
    {
        if (!$this->options->getConnection()->isConnected()) {
            $this->options->getConnection()->connect();
        }
    }
    
    /**
     * @throws \Exception
     */
    private function disconnect() : void
    {
        if ($this->options->getConnection()->isConnected()) {
            $this->options->getConnection()->close();
        }
    }
    
    /**
     * Determine if this service is currently active.
     *
     * @return bool
     */
    final public function isActive() : bool
    {
        return $this->active;
    }
    
    /**
     * Set the active status of this service.
     *
     * @param bool $active
     *
     * @return ServiceInterface
     */
    final public function setActive(bool $active) : ServiceInterface
    {
        $this->active = $active;
        
        return $this;
    }
    
    /**
     * @param string $eventType
     *
     * @return string
     */
    final protected function getEventName(string $eventType) : string
    {
        return PathUtil::configKey($this->getEventNamespace(), $eventType);
    }
}
