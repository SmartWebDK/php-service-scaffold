<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Support\Signals;

/**
 * Definition of a signal handler.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
interface SignalHandlerInterface
{
    
    /**
     * @param int        $signal
     * @param array|null $info
     */
    public function handle(int $signal, ?array $info = null) : void;
    
    /**
     * Signals accepted by this handler.
     *
     * @return int[]
     */
    public function signals() : array;
}
