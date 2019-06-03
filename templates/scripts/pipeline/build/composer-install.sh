#!/usr/bin/env bash

workingDir="$(pwd)"

cmdFlags="-n --no-progress"
installCmd="composer install"

if [[ "$1" != "" ]]; then
    vendorDir="$1"

    if [[ ! -d ${vendorDir} ]] ; then
        echo "creating vendor dir: $vendorDir"
        mkdir ${vendorDir}
    fi

    composer config -g vendor-dir ${vendorDir}
fi

if [[ "$2" != "" ]]; then
    githubAuthToken="$2"
    composer config -g github-oauth.github.com ${githubAuthToken}
fi

if [[ "$3" != "" ]]; then
    additionalCmdFlags="$3"
    cmdFlags="$cmdFlags $additionalCmdFlags"
fi

cmd="$installCmd $cmdFlags"

echo "Executing: $cmd"

${cmd}
