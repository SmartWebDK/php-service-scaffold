version: '2.1'

services:

  composer:
    image: composer
    volumes:
    - .:/app
    - composer-cache:/tmp

  artisan:
    image: smartweb/php:7.1-cli-dev
    entrypoint: 'php artisan'
    working_dir: '/app'
    volumes:
    - .:/app

  bash:
    image: smartweb/php:7.1-fpm-dev
    entrypoint: 'bash'
    working_dir: '/app'
    volumes:
    - .:/app

  codecept:
    image: smartweb/php:7.1-cli-dev
    entrypoint: 'php vendor/bin/codecept'
    working_dir: '/app'
    volumes:
    - .:/app

  nats-streaming:
    image: nats-streaming
    command: "--config '/opt/nats/nats.yml' -D"
    working_dir: /app
    volumes:
      - .:/app
      - ./config/nats/nats.yml:/opt/nats/nats.yml

  database:
    image: mysql/mysql-server:5.6
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_ROOT_HOST: '%.%.%.%'
      MYSQL_DATABASE: {{.Name}}
    volumes:
    - db-data:/var/lib/mysql
    ports:
    - 3306:3306

  rabbitmq:
    image: rabbitmq:3.6-management-alpine
    ports:
      - 15672:15672

volumes:
  db-data:
    driver: local
  composer-cache:
    driver: local
