#!/bin/bash
# ************************************************************************
# check-install-utils

# The script checks the installation of utils
# [Скрипт проверяет установку утилит]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function check-install-utils

# checking the necessary installed utilities
# [Проверка установки утилит]
check-install-utils(){ # args: program_1 ... program_N
    # --------------------------------------------------------------------
    # programs that need to be checked for installation
    # [программы которые нужно проверить на установку]
    local arr=( "${@}" ) # local arr=( "${*}" )
    echo ${arr[@]}

    # programs to install
    # [программы которые нужно установить]
    local utils

    # checking the necessary installed utilities
    # [Проверка установки утилит]
    for app in ${arr[@]}; do
        # local app_path=$( which $app ) # test [тест]
        # echo $app_path # test [тест]

        # 0 - the program is installed, 1 and more - not
        # [0 - программа установленна, 1 и больше - нет]
        which ${app} &> /dev/null
        local bool=$( echo  ${?} )
        if [ 0 -ne ${bool} ]; then
            # echo "You need to install the ${app} to continue"
            # exit ${bool}
            app+="\n"
            utils+=( ${app} )
        fi
    done

    # You need to install the following programs
    # [Нужно установить следующие программы]
    echo -e "You need to install the following programs:\n ${utils[@]}"
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f check-install-utils
# ************************************************************************
# tests

# check-install-utils # test
# utils=( date find git gzip ls mkdir rm tar which ) # test
# utils=( max date find git gzip ls mkdir rm tar which mer) # test
# check-install-utils "${utils[@]}" # test
# check-install-utils "max" "date" "find" "git" "gzip" "ls" "mkdir" "rm" "tar" "which" "mer" # test
# ************************************************************************