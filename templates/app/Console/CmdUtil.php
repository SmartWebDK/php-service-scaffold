<?php
declare(strict_types = 1);


namespace App\Console;

/**
 * Utility methods for interacting with the command line.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 *
 * @api
 */
class CmdUtil
{
    
    /**
     * @param string[] $args
     * @param string   $key
     *
     * @return null|string
     */
    public static function extractFromArgs(array $args, string $key) : ?string
    {
        $argValue = null;
        $nextIsTarget = false;
        
        foreach ($args as $arg) {
            if ($nextIsTarget) {
                $argValue = $arg;
                break;
            }
            
            if (\strpos($arg, $key) === 0) {
                // Found the target arg, check if passed as single, or the next arg is target value
                if (\strlen($arg) >= 6) { // Including '=' sign
                    $argValue = \substr($arg, 6);
                    break;
                }
                
                $nextIsTarget = true;
            }
        }
        
        return $argValue;
    }
}
