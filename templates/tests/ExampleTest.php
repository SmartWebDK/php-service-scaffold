<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Tests;

use Laravel\Lumen\Testing\DatabaseMigrations;
use Laravel\Lumen\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function testExample() : void
    {
        $this->assertSame(1, 1);
    }
}
