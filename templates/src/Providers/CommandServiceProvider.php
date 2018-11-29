<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Providers;

use Illuminate\Support\ServiceProvider;
use SmartWeb\Webhooks\Console\Commands\RunCommand;

/**
 * Registers commands and requisite bindings.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class CommandServiceProvider extends ServiceProvider
{
    
    /**
     * Register any application services.
     */
    public function register() : void
    {
        $this->commands(
            [
                RunCommand::class,
            ]
        );
    }
}
