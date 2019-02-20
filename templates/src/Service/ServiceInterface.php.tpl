<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Service;

/**
 * The interface implemented by all services.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
interface ServiceInterface
{
    
    /**
     * Prefix used to build service names.
     */
    public const SERVICE_NAME_PREFIX = 'service.io.smartweb';
    
    /**
     * Get the fully-qualified name of this service.
     *
     * @return string
     */
    public function getName() : string;
    
    /**
     * Get the namespace used for events originating from this service.
     *
     * @return string
     */
    public function getEventNamespace() : string;
    
    /**
     * Get the version string of this service.
     * **MUST** return a version string formatted according to Semantic Versioning 2.0.0.
     *
     * @link https://semver.org/ For details on the format and meaning of valid version strings.
     *
     * @return string
     */
    public function getVersion() : string;
    
    /**
     * Run this service.
     */
    public function run() : void;
    
    /**
     * Determine if this service is currently active.
     *
     * @return bool
     */
    public function isActive() : bool;
    
    /**
     * Set the active status of this service.
     *
     * @param bool $active
     *
     * @return ServiceInterface
     */
    public function setActive(bool $active) : ServiceInterface;
}
