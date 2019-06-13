{
    "name": "smartweb/{{.Name.Hyphen}}",
    "description": "{{.Description}}",{{if .Author.Name}}
    "authors": [
        {
            "name": "{{.Author.Name}}"{{if .Author.Email}},
            "email": "{{.Author.Email}}"{{end}}
        }
    ],{{end}}
    "minimum-stability": "dev",
    "prefer-stable": true,
    "repositories": [
        {
            "type": "composer",
            "url": "https://composer.smartweb.io/"
        }
    ],
    "require": {
        "php": ">=7.3",
        "ext-pcntl": "*",
        "laravel/lumen-framework": "5.7.*",
        "smartweb/log": "^1.0",
        "smartweb/util": "^1.0",
        "smartweb/events": "~0.8",
        "smartweb/php-service": "~0.7",
        "vladimir-yuldashev/laravel-queue-rabbitmq": "^7.0",
        "vlucas/phpdotenv": "~2.2"
    },
    "require-dev": {
        "ext-mbstring": "*",
        "roave/security-advisories": "dev-master",
        "phpunit/phpunit": "^7",
        "fzaninotto/faker": "~1.4",
        "mockery/mockery": "~1.0",
        "smartweb/codeception-lumen": "^3.0",
        "smartweb/testing": "^1.3"
    },
    "autoload": {
        "classmap": [
            "database/seeds",
            "database/factories"
        ],
        "psr-4": {
            "App\\": "app/",
            "{{.Data.composerNamespace}}\\": "src/"
        }
    },
    "autoload-dev": {
        "classmap": [
            "tests/"
        ],
        "psr-4": {
            "{{.Data.composerNamespace}}\\Testing\\": "testing/",
            "{{.Data.composerNamespace}}\\Tests\\": "tests/"
        }
    },
    "scripts": {
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ]
    },
    "bin": [
        "artisan"
    ],
    "config": {
        "preferred-install": "dist",
        "sort-packages": true,
        "optimize-autoloader": true,
        "platform": {
            "php": "7.3",
            "ext-bcmath": "0.1",
            "ext-mbstring": "0.1",
            "ext-pcntl": "0.1"
        }
    }
}
