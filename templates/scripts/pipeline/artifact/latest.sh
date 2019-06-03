#!/usr/bin/env bash

if [[ "$1" != "" ]]; then
    localBinPath="$1"
else
    echo "Missing path to local bin"
    exit 1
fi

if [[ ! -f ${localBinPath} ]]; then
    echo "Invalid path to local bin: $localBinPath"
    exit 1
fi

if [[ "$2" != "" ]]; then
    folder="$2"
else
    echo "Missing S3 target: folder name"
    exit 1
fi

if [[ "$3" != "" ]]; then
    remoteBinName="$3"
else
    echo "Missing S3 target: binary name"
    exit 1
fi

binExt=""

if [[ "$4" != "" ]]; then
    binExt="$4"
fi

aws s3 cp ${localBinPath} s3://smartweb-artifacts/${folder}/${remoteBinName}-latest${binExt}
aws s3 cp ${localBinPath} s3://smartweb-artifacts/${folder}/${remoteBinName}-${CI_COMMIT_SHA}${binExt}
