<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Providers;

use Illuminate\Support\ServiceProvider;
use SmartWeb\Testing\Module\Module;
use SmartWeb\Testing\Module\ModuleRegistry;
use SmartWeb\Util\PathUtil;

/**
 * @author {{.Author.Name}} <{{.Author.Email}}>
 */
class TestingServiceProvider extends ServiceProvider
{

    public function boot() : void
    {
        $this->registerTestingModule();
    }

    private function registerTestingModule() : void
    {
        $name = \env('APP_NAME');
        $rootDir = \dirname(__DIR__, 2);

        PathUtil::setLaravelRootDir($rootDir);

        ModuleRegistry::getInstance()->set(
            $name,
            new Module(
                $name,
                $rootDir,
                \env('APP_NS'),
                \env('APP_TESTS_DIR')
            )
        );
    }
}
