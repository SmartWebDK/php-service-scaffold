<?php
declare(strict_types = 1);


namespace App\Console;

use Dotenv\Dotenv;

/**
 * Loads .env files.
 *
 * @author Nicolai Agersbæk <na@zitcom.dk>
 *
 * @api
 */
class EnvLoader
{
    
    /**
     * Default maximum depth at which to search for a given env file.
     */
    public const DEFAULT_MAX_SEARCH_DEPTH = 10;
    
    /**
     * @param string   $baseDir
     * @param string   $envFile
     * @param int|null $maxSearchDepth
     */
    public static function loadEnvFile(string $baseDir, string $envFile, ?int $maxSearchDepth = null) : void
    {
        $maxSearchDepth = $maxSearchDepth ?? self::DEFAULT_MAX_SEARCH_DEPTH;
        
        $envLoaded = false;
        
        for ($i = 1; $i <= $maxSearchDepth; $i++) {
            $dir = \dirname($baseDir, $i);
            $file = $dir . '/' . $envFile;
            
            if (file_exists($file)) {
                (new Dotenv($dir, $envFile))->load();
                $envLoaded = true;
            } else {
                \printf("File not found: {$file}\n");
            }
        }
        
        if (!$envLoaded) {
            throw new \RuntimeException("Failed to find configuration file: {$envFile}");
        }
    }
}
