<?php
declare(strict_types = 1);


namespace App\Console;

use Illuminate\Support\Arr;
use Illuminate\Support\Str;

/**
 * Utility for helping with detecting environment and environment files.
 *
 * @author Nicolai Agersbæk <na@zitcom.dk>
 *
 * @api
 */
class EnvironmentDetector
{
    
    /**
     * @param array       $args
     * @param string|null $default
     *
     * @return string|null
     */
    public static function detectEnvironment(array $args, ?string $default = null) : ?string
    {
        return self::detectConsoleEnvironment($args, $default);
    }
    
    /**
     * @param array|null  $args
     * @param string|null $defaultEnv
     *
     * @return string
     */
    public static function detectEnvFile(?array $args = null, ?string $defaultEnv = null) : string
    {
        $env = self::detectEnvironment($args, $defaultEnv);
        
        return $env !== null
            ? ".env.{$env}"
            : '.env';
    }
    
    /**
     * Set the application environment from command-line arguments.
     *
     * @param array  $args
     * @param string $default
     *
     * @return string|null
     */
    public static function detectConsoleEnvironment(array $args, ?string $default) : ?string
    {
        // First we will check if an environment argument was passed via console arguments
        // and if it was that automatically overrides as the environment. Otherwise, we
        // will check the environment as a "web" request like a typical HTTP request.
        $value = self::getEnvironmentArgument($args);
        if ($value !== null) {
            return (string)\head(\array_slice(\explode('=', $value), 1));
        }
        
        return $default;
    }
    
    /**
     * Get the environment argument from the console.
     *
     * @param  array $args
     *
     * @return string|null
     */
    public static function getEnvironmentArgument(array $args) : ?string
    {
        return Arr::first(
            $args,
            function ($value) {
                return Str::startsWith($value, '--env');
            }
        );
    }
}
