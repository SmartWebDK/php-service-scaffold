#!/usr/bin/env bash

echo "$JENKINS_SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [[ ! -f "~/.ssh/known_hosts" ]]; then
    ssh-keyscan gitlab.zitcom.dk >> ~/.ssh/known_hosts
    chmod 644 ~/.ssh/known_hosts
fi

[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
