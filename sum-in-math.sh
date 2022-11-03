#!/bin/bash
# ************************************************************************
# connecting library functions
# [подключаем функции-библиотеки]
if [[ 0 -ne $( type check-install-utils &> /dev/null; echo ${?} ) ]]; then
    source check-install-utils.sh
fi
# ************************************************************************
# connecting the script
# [подключаем скрипт]
cd ./src/sum-in-math/
source ./sum-in-math.sh
cd ../../
# ************************************************************************