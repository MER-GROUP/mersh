#!/bin/bash
# ************************************************************************
# check_install_utils

# The script checks the installation of utils
# [Скрипт проверяет установку утилит]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function check_install_utils

# checking the necessary installed utilities
# [Проверка установки утилит]
check_install_utils(){ # args: program_1 ... program_N
    # --------------------------------------------------------------------
    # required installed programs [необходимые установленные программы]
    local arr=( "${*}" )
    echo ${arr[@]}

    # # checking the necessary installed utilities
    # # [проверка необходимых установленных утилит]
    # for app in ${arr[@]}; do
    #     # # test [тест]
    #     # local app_path=$( which $app )
    #     # echo $app_path

    #     # 0 - the program is installed, 1 and more - not
    #     # [0 - программа установленна, 1 и больше - нет]
    #     which ${app} &> /dev/null
    #     local bool=$( echo  ${?} )
    #     if [ 0 -ne ${bool} ]; then
    #         echo "You need to install the ${app} to continue"
    #         exit ${bool}
    #     fi
    # done
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f check_install_utils
# ************************************************************************
# tests

# check_install_utils # test
# check_install_utils "1" "2" "3" "1" "2" "3" "1" "2" "3" # test
# check_install_utils "1" "2" "3" "1" "2" "1" "2" "3" "4" "5" "6" # test
# ************************************************************************