<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Contracts\Events\Dispatcher;
use Illuminate\Support\ServiceProvider;
use {{.Data.namespace}}\Listeners\SampleEventHandler;

/**
 * Registers event listeners for the service.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
 */
class EventServiceProvider extends ServiceProvider
{

    /**
     * Boot the application services.
     *
     * @param Dispatcher $dispatcher
     */
    public function boot(Dispatcher $dispatcher) : void
    {
        $dispatcher->listen('io.smartweb.dummy.sample-event', SampleEventHandler::class);
    }
}
