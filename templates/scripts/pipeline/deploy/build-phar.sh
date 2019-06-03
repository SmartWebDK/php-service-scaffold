#!/usr/bin/env bash

if [[ ! -f "box.phar" ]]; then
    curl -L https://github.com/humbug/box/releases/download/3.0.0-beta.4/box.phar --output box.phar
fi
php box.phar compile
