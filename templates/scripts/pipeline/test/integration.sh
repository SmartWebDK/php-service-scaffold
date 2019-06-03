#!/usr/bin/env bash

cp .env.testing .env
php artisan service:setup --reset -vvv
php artisan migrate -vvv
php artisan testing:run-suite Integration --env=testing
