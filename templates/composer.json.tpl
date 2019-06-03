{
    "name": "smartweb/{{.NameSlug}}",
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
        "php": ">=7.1",
        "ext-pcntl": "*",
        "laravel/lumen-framework": "5.7.*",
        "vlucas/phpdotenv": "~2.2",
        "smartweb/log": "^1.0",
        "smartweb/util": "^1.0",
        "smartweb/events": "~0.7",
        "smartweb/php-service": "~0.7"
    },
    "require-dev": {
        "ext-mbstring": "*",
        "roave/security-advisories": "dev-master",
        "phpunit/phpunit": "^7",
        "fzaninotto/faker": "~1.4",
        "mockery/mockery": "~1.0",
        "smartweb/testing": "^1.2"
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
            "{{.Data.composerNamespace}}\\Tests\\": "tests/"
        }
    },
    "scripts": {
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ]
    },
    "config": {
        "preferred-install": "dist",
        "sort-packages": true,
        "optimize-autoloader": true,
        "platform": {
            "php": "7.3",
            "ext-mbstring": "0.1",
            "ext-pcntl": "0.1"
        }
    }
}
