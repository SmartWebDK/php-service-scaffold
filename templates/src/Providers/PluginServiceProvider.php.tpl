<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class PluginServiceProvider extends ServiceProvider
{
    
    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->app->register(\SmartWeb\Testing\Providers\MainServiceProvider::class);
        $this->app->register(\SmartWeb\Laravel\Nats\Providers\NatsServiceProvider::class);
    }
}
