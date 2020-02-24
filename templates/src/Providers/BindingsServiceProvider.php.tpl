<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;
use {{.Data.namespace}}\Providers\Bindings\LogBindings;

/**
 * Registers container bindings for the service.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
*
* @internal
*/
class BindingsServiceProvider extends ServiceProvider
{

    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = true;

    public function register() : void
    {
        $this->app->register(LogBindings::class);
    }
}
