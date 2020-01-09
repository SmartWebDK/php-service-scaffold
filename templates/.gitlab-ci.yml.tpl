stages:
    - build
    - test
    - deploy

variables:
    SERVICE_NAME: "{{.Name.Underscore}}"

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

# Add this once your integration tests have been generated (if you need them)

#test:integration:
#    stage: test
#    image: smartweb/php:7.3-service-alpine
#    dependencies:
#        - build:install
#    services:
#        -   name: mysql/mysql-server:5.6
#            alias: db
#    variables:
#        MYSQL_ROOT_PASSWORD: password
#        MYSQL_ROOT_HOST: '%.%.%.%'
#        MYSQL_DATABASE: test_{{.Name.Underscore}}
#    script:
#        - sh scripts/pipeline/test/integration.sh

test:unit:
    stage: test
    image: smartweb/php:7.3-service-alpine
    dependencies:
        - build:install
    script:
        - sh scripts/pipeline/test/unit.sh

artifact:container:
    stage: artifact
    only:
        - master
    dependencies:
        - build:install
    image:
        name: docker:19.03.1
    script:
        - docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD
        - docker build --pull --build-arg SSH_KEY="${JENKINS_SSH_PRIVATE_KEY}" -t smartweb/${SERVICE_NAME}:master-${CI_COMMIT_SHORT_SHA} .
        - docker tag smartweb/${SERVICE_NAME}:master-${CI_COMMIT_SHORT_SHA} smartweb/${SERVICE_NAME}:latest
        - docker push smartweb/${SERVICE_NAME}:master-${CI_COMMIT_SHORT_SHA}
        - docker push smartweb/${SERVICE_NAME}:latest
    tags:
        - docker
