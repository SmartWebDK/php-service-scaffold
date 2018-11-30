<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Service;

/**
 * The SmartWeb webhooks service.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class ChangeClassNameService extends BaseService
{
    
    /**
     * The version of this service.
     */
    public const VERSION = '0.1.0';
    
    /**
     * The (fully-qualified) name of this service.
     */
    public const NAME = 'service.io.smartweb.{{.Name}}';
    
    /**
     * The namespace of events used by this service.
     */
    public const EVENT_NAMESPACE = 'io.smartweb.{{.Name}}';
    
    /**
     * @param ServiceOptionsInterface $options
     */
    public function __construct(ServiceOptionsInterface $options)
    {
        parent::__construct(
            self::NAME,
            self::EVENT_NAMESPACE,
            self::VERSION,
            $options
        );
    }
    
    /**
     * Initialize the service.
     */
    protected function init() : void
    {
        // Register subscription handlers
    }
}
