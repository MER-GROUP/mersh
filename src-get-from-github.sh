#!/bin/bash
# ************************************************************************
# connecting library functions
# [подключаем функции-библиотеки]
if [[ 0 -ne $( type check-install-utils &> /dev/null; echo ${?} ) ]]; then
    source check-install-utils.sh
fi
if [[ 0 -ne $( type set-in-math &> /dev/null; echo ${?} ) ]]; then
    source set-in-math.sh
fi
# ************************************************************************
# connecting the script
# [подключаем скрипт]
cd ./src/src-get-from-github/
source ./src-get-from-github.sh
cd ../../
# ************************************************************************