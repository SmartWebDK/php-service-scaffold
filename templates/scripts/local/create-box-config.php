<?php
declare(strict_types = 1);

use Symfony\Component\Finder\Finder;

require_once __DIR__ . '/../../vendor/autoload.php';

$finder = Finder::create();


static $baseDir = __DIR__ . '/../../';
static $migrationsDirName = 'database/migrations';

$migrationsDir = \SmartWeb\Util\PathUtil::path($baseDir, $migrationsDirName);

$migrations = $finder->in($migrationsDir)->files();

$migrationFiles = Finder::create()
    ->in($migrationsDir)
//    ->name('database\/migrations\/*.php');
    ->name('*.php');
//->files();
//$migrationFiles = Finder::create()->in($migrationsDir)->name('*.php');
dd(iterator_to_array($migrationFiles));

$files = [
    '.env',
    'bootstrap/app.php',
    'bootstrap/autoload.php',
    'config/queue.php',
    'config/webhooks.php',
    'database/migrations/2018_11_21_100603_create_webhooks_table.php',
    'database/migrations/2018_11_21_122914_create_logs_table.php',
    'database/migrations/2019_03_07_144807_create_secrets_table.php',
    'database/migrations/2019_03_26_103926_create_failed_jobs_table.php',
];

$config = [
    'compression' => '',
    'output'      => 'bin/wds.phar',
    'files'       => $files,
];

$json = \json_encode($config, \JSON_THROW_ON_ERROR);

$json = str_replace('\\/', '/', $json);

static $filename = 'box-test.json';

\file_put_contents($filename, $json);

echo "Wrote configuration to: {$filename}\n";
