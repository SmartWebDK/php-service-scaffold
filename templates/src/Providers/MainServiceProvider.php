<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Providers;

use Illuminate\Contracts\Container\Container;
use Illuminate\Support\ServiceProvider;
use NatsStreaming\Connection;
use Psr\Log\LoggerInterface;
use SmartWeb\Log\Formatter\ErrorMessageFormatter;
use SmartWeb\Log\ModularLogger;
use SmartWeb\Log\Output\ErrorLogOutput;
use SmartWeb\Webhooks\Service\WebhooksService;
use SmartWeb\Webhooks\Service\ServiceInterface;
use SmartWeb\Webhooks\Service\ServiceOptions;
use SmartWeb\Webhooks\Service\ServiceOptionsInterface;

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
            'io.smartweb.webhooks.service.options',
            function (Container $container) : ServiceOptionsInterface {
                return new ServiceOptions(
                    $container->get(Connection::class),
                    $container->get(LoggerInterface::class)
                );
            }
        );
        
        $this->app->singleton(
            'io.smartweb.webhooks.service',
            function (Container $container) : ServiceInterface {
                return new WebhooksService($container->get('io.smartweb.webhooks.service.options'));
            }
        );
        
        $this->app->alias('io.smartweb.webhooks.service', ServiceInterface::class);
        
        // TODO: Move to using properly configured logger from Monolog (may need custom handlers/processors)
        $this->app->bind(
            LoggerInterface::class,
            function () : LoggerInterface {
                return new ModularLogger(
                    new ErrorLogOutput(), new ErrorMessageFormatter(WebhooksService::EVENT_NAMESPACE)
                );
            }
        );
    }
}
