stages:
    - build
    - test
    - deploy
    - artifact

build:install:
    stage: build
    image: composer
    cache:
        key: composer-cache
        paths:
            - vendor/
    script:
        - eval $(ssh-agent -s)
        - sh scripts/pipeline/build/setup-ssh.sh
        - sh scripts/pipeline/build/composer-install.sh vendor ${JENKINS_GITHUB_PERSONAL_TOKEN}
    artifacts:
        paths:
            - vendor/
        expire_in: 1 day

test:integration:
    stage: test
    image: smartweb/php:7.3-service-alpine
    dependencies:
        - build:install
    services:
        -   name: mysql/mysql-server:5.6
            alias: db
    variables:
        MYSQL_ROOT_PASSWORD: password
        MYSQL_ROOT_HOST: '%.%.%.%'
        MYSQL_DATABASE: test_{{.NameSlug}}
    script:
        - sh scripts/pipeline/test/integration.sh

test:unit:
    stage: test
    image: smartweb/php:7.3-service-alpine
    dependencies:
        - build:install
    script:
        - sh scripts/pipeline/test/unit.sh
