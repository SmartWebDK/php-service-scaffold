#!/usr/bin/env bash

workingDir="$(pwd)"

if [[ "$1" != "" ]]; then
    vendorDirName="$1"
else
    vendorDirName="vendor"
fi

if [[ "$2" != "" ]]; then
    testsDirName="$2"
else
    testsDirName="tests"
fi

testsDir="$workingDir/$testsDirName"

if [[ ! -d ${testsDir} ]]; then
    echo "no dir containing tests"
else
    vendorDir="$workingDir/$vendorDirName"
    phpUnit="$vendorDir/bin/phpunit"
    codecept="$vendorDir/bin/codecept"
    autoload="$vendorDir/autoload.php"

    artisan="$workingDir/artisan"
    testingLib="$vendorDir/smartweb/testing"

    if [[ ! -d ${vendorDir} ]] ; then
        echo "invalid vendor dir '$vendorDir'"
        exit
    fi

    if [[ ! -f ${autoload} ]] ; then
        echo "missing autoload file '$autoload'"
        exit
    fi

    if [[ ! -f ${artisan} ]] ; then
        artisanSupported=false
    else
        artisanSupported=true
    fi

    echo "Artisan supported: $artisanSupported"

    if [[ ! -d ${testingLib} ]] ; then
        testingLibSupported=false
    else
        testingLibSupported=true
    fi

    echo "'smartweb/testing' supported: $testingLibSupported"

    if [[ ! -f ${phpUnit} ]] ; then
        validPhpUnit=false
    else
        echo "Found PHPUnit binary: '$phpUnit'"
        validPhpUnit=true
    fi

    if [[ ! -f ${codecept} ]] ; then
        validCodeception=false
    else
        echo "Found Codeception binary: '$phpUnit'"
        validCodeception=true
    fi

    if [[ ${validCodeception} == true && ${artisanSupported} == true && ${testingLibSupported} == true ]] ; then
        echo "Running Codeception tests (using Artisan)"
        VENDOR_DIR_NAME="$vendorDirName" php ${artisan} testing:run-suite Unit --env=testing
        exit
    fi

    if [[ ${validCodeception} == true ]] ; then
        echo "Running Codeception tests"
        php ${codecept} run
        exit
    fi

    if [[ ${validPhpUnit} == true ]] ; then
        echo "Running PHPUnit tests"
        php ${phpUnit} ${testsDir} --bootstrap=${autoload}
        exit
    fi

    echo "No testing framework found!"
fi
