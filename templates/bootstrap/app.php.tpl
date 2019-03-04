<?php
declare(strict_types = 1);

require_once __DIR__ . '/autoload.php';

$envFile = \App\Console\EnvironmentDetector::detectEnvFile($_SERVER['argv'] ?? null);

try {
    \App\Console\EnvLoader::loadEnvFile(__DIR__, $envFile);
} catch (\Dotenv\Exception\InvalidPathException $err) {
    \printf(
        '[warning] %s in %s:%d%s',
        $err->getMessage(),
        $err->getFile(),
        $err->getLine(),
        PHP_EOL
    );
} catch (\App\Exceptions\InvalidPathException $err) {
    \printf(
        "[warning] %s, at path '%s' in %s:%d%s",
        $err->getMessage(),
        $err->getPath(),
        $err->getFile(),
        $err->getLine(),
        PHP_EOL
    );
}

/*
|--------------------------------------------------------------------------
| Create The Application
|--------------------------------------------------------------------------
|
| Here we will load the environment and create the application instance
| that serves as the central piece of this framework. We'll use this
| application as an "IoC" container and router for this framework.
|
*/

$app = new \Laravel\Lumen\Application(
    \dirname(__DIR__)
);

// $app->withFacades();

$app->withEloquent();

/*
|--------------------------------------------------------------------------
| Register Container Bindings
|--------------------------------------------------------------------------
|
| Now we will register a few bindings in the service container. We will
| register the exception handler and the console kernel. You may add
| your own bindings here if you like or you can make another file.
|
*/

$app->singleton(
    \Illuminate\Contracts\Debug\ExceptionHandler::class,
    \App\Exceptions\Handler::class
);

$app->singleton(
    \Illuminate\Contracts\Console\Kernel::class,
    \App\Console\Kernel::class
);

/*
|--------------------------------------------------------------------------
| Register Middleware
|--------------------------------------------------------------------------
|
| Next, we will register the middleware with the application. These can
| be global middleware that run before and after each request into a
| route or middleware that'll be assigned to some specific routes.
|
*/

// $app->middleware([
//    \App\Http\Middleware\ExampleMiddleware::class
// ]);

// $app->routeMiddleware([
//     'auth' => \App\Http\Middleware\Authenticate::class,
// ]);

/*
|--------------------------------------------------------------------------
| Register Service Providers
|--------------------------------------------------------------------------
|
| Here we will register all of the application's service providers which
| are used to bind services into the container. Service providers are
| totally optional, so you are not required to uncomment this line.
|
*/

$app->register({{.Data.namespace}}\Providers\MainServiceProvider::class);

/*
|--------------------------------------------------------------------------
| Load The Application Routes
|--------------------------------------------------------------------------
|
| Next we will include the routes file so that they can all be added to
| the application. This will provide all of the URLs the application
| can respond to, as well as the controllers that may handle them.
|
*/

//$app->router->group([
//    'namespace' => 'App\Http\Controllers',
//], function ($router) {
//    require __DIR__.'/../routes/web.php';
//});

return $app;
