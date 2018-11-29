<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Providers;

use Illuminate\Support\ServiceProvider;
use SmartWeb\Testing\Codeception\Setup;
use SmartWeb\Testing\Module\Module;
use SmartWeb\Testing\Module\ModuleRegistry;
use SmartWeb\Webhooks\Console\Commands\SampleCommand;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class TestingServiceProvider extends ServiceProvider
{
    
    public function boot() : void
    {
        Setup::setDefaultTestsDir('tests');
        
        ModuleRegistry::getInstance()->set(
            'webhooks',
            new Module('webhooks', __DIR__ . '/../../src', 'SmartWeb\\Webhooks\\')
        );
    }
    
    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->commands(
            [
                SampleCommand::class,
            ]
        );
    }
}
