<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Contracts\Container\Container;
use Illuminate\Support\ServiceProvider;
use NatsStreaming\Connection;
use Psr\Log\LoggerInterface;
use SmartWeb\Log\Formatter\ErrorMessageFormatter;
use SmartWeb\Log\ModularLogger;
use SmartWeb\Log\Output\ErrorLogOutput;

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
