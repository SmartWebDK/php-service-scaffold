version: '3'

services:

  composer:
    image: composer
    volumes:
      - .:/app
      - composer-cache:/tmp

  artisan:
    image: smartweb/php-service-7.3
    entrypoint: 'php artisan'
    working_dir: /app
    volumes:
      - .:/app
    networks:
      - local
      - global

  codecept:
    image: smartweb/php-service-7.3
    entrypoint: 'php vendor/bin/codecept'
    working_dir: /app
    volumes:
      - .:/app

  db:
    image: mysql/mysql-server:5.6
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_ROOT_HOST: '%.%.%.%'
      MYSQL_DATABASE: {{.Name.Underscore}}
    volumes:
      - db-data:/var/lib/mysql
    ports:
      - 3307:3306
    networks:
      - local

  php:
    image: smartweb/php-service-7.3
    entrypoint: 'php'
    working_dir: /app
    volumes:
      - .:/app
    networks:
      - local

  queue:
    image: rabbitmq:3.6-management-alpine
    environment:
      VIRTUAL_HOST: rabbitmq.{{.Name.Hyphen}}.test
      VIRTUAL_PORT: 15672
    networks:
      - local

volumes:
  db-data:
  composer-cache:

networks:
  global:
    external: true
  local:
