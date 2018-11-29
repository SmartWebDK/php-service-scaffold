<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Tests;

use Laravel\Lumen\Application;

/**
 * Base test case.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
abstract class TestCase extends \Laravel\Lumen\Testing\TestCase
{
    
    /**
     * Creates the application.
     *
     * @return Application
     */
    public function createApplication() : Application
    {
        return require __DIR__ . '/../bootstrap/app.php';
    }
}
