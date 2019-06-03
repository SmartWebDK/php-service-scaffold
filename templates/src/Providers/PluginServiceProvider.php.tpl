<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;
use SmartWeb\Laravel\Nats\Providers\DispatcherPluginServiceProvider;
use SmartWeb\Laravel\Nats\Providers\NatsServiceProvider;
use SmartWeb\Service\Providers\MainServiceProvider as ServiceMainServiceProvider;
use SmartWeb\Testing\Providers\MainServiceProvider as TestingMainServiceProvider;
use VladimirYuldashev\LaravelQueueRabbitMQ\LaravelQueueRabbitMQServiceProvider;

/**
 * Registers providers from plugins.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
 */
class PluginServiceProvider extends ServiceProvider
{

    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->app->register(ServiceMainServiceProvider::class);
        $this->app->register(NatsServiceProvider::class);
        $this->app->register(DispatcherPluginServiceProvider::class);
        $this->app->register(LaravelQueueRabbitMQServiceProvider::class);

        if ($this->app->environment() === 'testing') {
            $this->app->register(TestingMainServiceProvider::class);
        }
    }
}
