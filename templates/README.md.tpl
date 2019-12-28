# {{.Name}}

## Description
{{.Description}}

This service is based on lumen 5.7 framework and adjusted to fit into team.blue ecom enviroment.

# Getting started

```
# Make system specific docker-compose.override.yml
cp docker-compose.override.sample.yml docker-compose.override.yml

# Outcomment your system

# Install dependencies
docker-compose run --rm composer install

# Start the web server. 
docker-compose up -d auth db

# Start service with no HTTP
docker-compose run --rm artisan service:run

# Test the service 
open http://localhost:8080 and see 404.
```

# Commands

## Start service
Start non-http service
```
docker-compose run --rm artisan service:run
```

## Bootstrap service
This command will create the schema and run migrations
```
# Create schema and run migrations
docker-compose run --rm artisan service:setup
```

## Migrations
```
# Run migrations
docker-compose run --rm artisan migrate

# Rollback one migration
docker-compose run --rm artisan migrate:rollback

# Create a migration
docker-compose run --rm artisan make:migration somenewtable
```

## Docs

Lumen: https://lumen.laravel.com/docs/5.7