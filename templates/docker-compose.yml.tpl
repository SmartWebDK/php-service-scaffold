version: '3'

services:

  composer:
    image: composer
    volumes:
      - .:/app
      - composer-cache:/tmp
      - ~/.ssh:/home/${USER}/.ssh
      - /etc/passwd:/etc/passwd:ro
    user: 1000:1000

  artisan:
    image: smartweb/php-service-7.3
    entrypoint: 'php artisan'
    working_dir: '/app'
    user: 1000:1000
    environment:
      XDEBUG_CONFIG: idekey=PHPSTORM remote_host=192.168.1.167 remote_enable=1
      PHP_IDE_CONFIG: serverName=docker
    volumes:
      - .:/app
    networks:
      - local
      - global

  codecept:
    image: smartweb/php-service-7.3
    user: 1000:1000
    entrypoint: 'php vendor/bin/codecept'
    working_dir: '/app'
    volumes:
      - .:/app

  db:
    image: mysql/mysql-server:5.6
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_ROOT_HOST: '%.%.%.%'
      MYSQL_DATABASE: {{.NameSlug}}
    volumes:
      - db-data:/var/lib/mysql
    ports:
      - 3307:3306
    networks:
      - local

  queue:
    image: rabbitmq:3.6-management-alpine
    environment:
      VIRTUAL_HOST: rabbitmq.{{.NameSlug}}.test
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
