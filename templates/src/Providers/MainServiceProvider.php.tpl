<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;

/**
 * @author {{.Author.Name}} <{{.Author.Email}}>
 */
class MainServiceProvider extends ServiceProvider
{

    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->registerProviders();
    }

    private function registerProviders() : void
    {
        $this->app->register(BindingsServiceProvider::class);
        $this->app->register(ConfigServiceProvider::class);
        $this->app->register(PluginServiceProvider::class);

        /** @noinspection ClassConstantCanBeUsedInspection */
        $this->registerDevProvider('\{{.Data.namespace}}\Testing\Providers\TestingServiceProvider');
    }

    /**
    * Register the given provider class if it exists.
    *
    * @param string $cls
    */
    private function registerDevProvider(string $cls) : void
    {
        if (\class_exists($cls)) {
            $this->app->register($cls);
        }
    }
}
