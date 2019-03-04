<?php
declare(strict_types = 1);


namespace App\Exceptions;

/**
 * Exception thrown when an invalid path is given.
 *
 * @author Nicolai Agersbæk <na@zitcom.dk>
 *
 * @api
 */
class InvalidPathException extends InvalidArgumentException
{
    
    /**
     * @var string
     */
    private $path;
    
    /**
     * @param string          $path     The invalid path that triggered this E xception.
     * @param string|null     $message  [optional] The Exception message to throw.
     * @param int|null        $code     [optional] The Exception code.
     * @param \Throwable|null $previous [optional] The previous throwable used for the exception chaining.
     */
    public function __construct(string $path, string $message = null, ?int $code = null, ?\Throwable $previous = null)
    {
        $this->path = $path;
        
        parent::__construct($message, $code, $previous);
    }
    
    /**
     * @return string
     */
    public function getPath() : string
    {
        return $this->path;
    }
}
