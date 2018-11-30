version: '2.1'

services: 
  composer:
    volumes:
        - ~/.ssh:/root/.ssh
    environment:
      SSH_KEY: /root/.ssh/id_rsa
      GIT_SSH_COMMAND: ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
      