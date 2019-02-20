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
use {{.Data.namespace}}\Service\ChangeClassNameService;
use {{.Data.namespace}}\Service\ServiceInterface;
use {{.Data.namespace}}\Service\ServiceOptions;
use {{.Data.namespace}}\Service\ServiceOptionsInterface;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class MainServiceProvider extends ServiceProvider
{
    
    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->registerProviders();
        $this->registerBindings();
    }
    
    private function registerProviders() : void
    {
        $this->app->register(CommandServiceProvider::class);
        $this->app->register(PluginServiceProvider::class);
        
        if ($this->app->environment() === 'testing') {
            $this->app->register(TestingServiceProvider::class);
        }
    }
    
    private function registerBindings() : void
    {
        $this->app->singleton(
            'io.smartweb.{{.Name}}.service.options',
            function (Container $container) : ServiceOptionsInterface {
                return new ServiceOptions(
                    $container->get(Connection::class),
                    $container->get(LoggerInterface::class)
                );
            }
        );
        
        $this->app->singleton(
            'io.smartweb.{{.Name}}.service',
            function (Container $container) : ServiceInterface {
                return new ChangeClassNameService($container->get('io.smartweb.{{.Name}}.service.options'));
            }
        );
        
        $this->app->alias('io.smartweb.{{.Name}}.service', ServiceInterface::class);
        
        // TODO: Move to using properly configured logger from Monolog (may need custom handlers/processors)
        $this->app->bind(
            LoggerInterface::class,
            function () : LoggerInterface {
                return new ModularLogger(
                    new ErrorLogOutput(), new ErrorMessageFormatter(ChangeClassNameService::EVENT_NAMESPACE)
                );
            }
        );
    }
}
