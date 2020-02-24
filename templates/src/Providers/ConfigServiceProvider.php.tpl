<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Contracts\Events\Dispatcher;
use Illuminate\Support\ServiceProvider;
use {{.Data.namespace}}\Listeners\SampleEventHandler;

/**
 * Registers configuration for the service.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
 *
 * @internal
 */
class ConfigServiceProvider extends ServiceProvider
{

    /**
    * Boot the application events.
    */
    public function boot() : void
    {
        $this->registerConfig();
    }

    private function registerConfig() : void
    {
        $this->mergeConfigFrom(__DIR__ . '/../../config/logging.php', 'logging');
        $this->mergeConfigFrom(__DIR__ . '/../../config/queue.php', 'queue');
    }
}
