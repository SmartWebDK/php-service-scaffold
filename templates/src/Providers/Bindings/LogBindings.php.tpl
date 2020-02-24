<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers\Bindings;

use Illuminate\Support\ServiceProvider;
use Monolog\Handler\ErrorLogHandler;
use Psr\Log\LoggerInterface;
use SmartWeb\Log\Formatter\LineFormatter;
use SmartWeb\Log\Logger;

/**
 * Registers bindings for logging.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
 *
 * @internal
 */
class LogBindings extends ServiceProvider
{

    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = true;

    public function register() : void
    {
        $this->registerLoggerIfNeeded();
    }

    private function registerLoggerIfNeeded() : void
    {
        $this->app->bindIf(
            LoggerInterface::class,
            static function () : LoggerInterface {
                $logLevel = \env('LOG_LEVEL', Logger::INFO);

                $handler = new ErrorLogHandler(
                    ErrorLogHandler::OPERATING_SYSTEM,
                    $logLevel,
                    false,
                    false
                );

                $handler->setFormatter(new LineFormatter());

                $appId = \env('APP_ID');
                $logger = new Logger($appId);

                return $logger->pushHandler($handler);
            }
        );
    }

    /**
     * Get the services provided by the provider.
     *
     * @return string[]
     */
    final public function provides() : array
    {
        return [
            LoggerInterface::class,
        ];
    }
}
