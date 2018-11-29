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

    if [[ ! -d ${vendorDir} ]] ; then
        echo "invalid vendor dir '$vendorDir'"
        exit
    fi

    if [[ ! -f ${autoload} ]] ; then
        echo "missing autoload file '$autoload'"
        exit
    fi

    if [[ ! -f ${phpUnit} ]] ; then
        echo "missing PHPUnit binary '$phpUnit'"
        validPhpUnit=false
    else
        validPhpUnit=true
    fi

    if [[ ! -f ${codecept} ]] ; then
        echo "missing Codeception binary '$codecept'"
        validCodeception=false
    else
        validCodeception=true
    fi

    if [[ ${validCodeception} == true ]] ; then
        echo "Running Codeception tests: $validCodeception"
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
