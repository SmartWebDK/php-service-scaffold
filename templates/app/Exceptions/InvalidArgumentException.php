<?php
declare(strict_types = 1);


namespace App\Exceptions;

/**
 * Exception thrown if an argument does not match with the expected value.
 *
 * @author Nicolai Agersbæk <na@zitcom.dk>
 *
 * @api
 */
class InvalidArgumentException extends \InvalidArgumentException implements ExceptionInterface
{
    
    /**
     * @param string|null     $message  [optional] The Exception message to throw.
     * @param int|null        $code     [optional] The Exception code.
     * @param \Throwable|null $previous [optional] The previous throwable used for the exception chaining.
     */
    public function __construct(?string $message = null, ?int $code = null, ?\Throwable $previous = null)
    {
        parent::__construct($message ?? '', $code ?? 0, $previous);
    }
}
