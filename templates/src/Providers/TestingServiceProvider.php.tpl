<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;
use SmartWeb\Testing\Codeception\Setup;
use SmartWeb\Testing\Module\Module;
use SmartWeb\Testing\Module\ModuleRegistry;
use {{.Data.namespace}}\Console\Commands\SampleCommand;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class TestingServiceProvider extends ServiceProvider
{
    
    public function boot() : void
    {
        Setup::setDefaultTestsDir('tests');
        
        ModuleRegistry::getInstance()->set(
            '{{.Name}}',
            new Module('{{.Name}}', __DIR__ . '/../../src', '{{.Data.composerNamespace}}')
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
