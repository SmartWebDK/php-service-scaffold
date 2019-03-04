<?php
declare(strict_types = 1);


namespace App\Console;

use App\Exceptions\InvalidPathException;
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
    public const DEFAULT_MAX_SEARCH_DEPTH = 1;
    
    /**
     * @param string    $baseDir
     * @param string    $envFile
     * @param int|null  $maxSearchDepth
     * @param bool|null $verbose
     */
    public static function loadEnvFile(
        string $baseDir,
        string $envFile,
        ?int $maxSearchDepth = null,
        ?bool $verbose = null
    ) : void {
        $maxSearchDepth = $maxSearchDepth ?? self::DEFAULT_MAX_SEARCH_DEPTH;
        $verbose = $verbose ?? false;
        
        self::printf($verbose, "Locating env file: {$envFile}\n");
        
        $envLoaded = false;
        $filePath = $envFile;
        
        for ($i = 1; $i <= $maxSearchDepth; $i++) {
            $dir = \dirname($baseDir, $i);
            $filePath = $dir . '/' . $envFile;
            
            if (file_exists($filePath)) {
                (new Dotenv($dir, $envFile))->load();
                $envLoaded = true;
            } else {
                self::printf($verbose, "File not found: {$filePath}\n");
            }
        }
        
        if (!$envLoaded) {
            throw new InvalidPathException($filePath, "Failed to find configuration file: {$envFile}");
        }
    }
    
    /**
     * @param bool   $verbose
     * @param string $format
     * @param mixed  ...$args
     */
    private static function printf(bool $verbose, string $format, ...$args) : void
    {
        if ($verbose) {
            \printf($format, ...$args);
        }
    }
}
