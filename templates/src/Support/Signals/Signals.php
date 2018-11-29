<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Support\Signals;

/**
 * Provides OOP access to process-control signal behavior.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class Signals
{
    
    public static function enableAsync() : void
    {
        \pcntl_async_signals(true);
    }
    
    public static function disableAsync() : void
    {
        \pcntl_async_signals(true);
    }
    
    /**
     * @param int                    $signal
     * @param SignalHandlerInterface $handler
     */
    public static function setHandler(int $signal, SignalHandlerInterface $handler) : void
    {
        if (!\in_array($signal, $handler->signals(), true)) {
            $signals = \implode(',', $handler->signals());
            throw new \LogicException(
                "Signal handler does not handle signal '{$signal}'; expected one of {{$signals}}"
            );
        }
        
        \pcntl_signal($signal, [$handler, 'handle']);
    }
}
