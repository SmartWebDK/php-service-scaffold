<?php
declare(strict_types = 1);

$vendorDirName = \getenv('VENDOR_DIR_NAME');

if (!\is_string($vendorDirName) || $vendorDirName === '') {
    $vendorDirName = 'vendor';
}

/** @noinspection PhpIncludeInspection */
require_once __DIR__ . "/../{$vendorDirName}/autoload.php";
