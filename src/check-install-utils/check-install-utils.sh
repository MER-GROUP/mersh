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
    # checking the installation of the utility - which
    # [проверка установки утилиты which]
    # if [[ 0 -eq $( type mer &> /dev/null; echo ${?} ) ]]; then # test
    if [[ 0 -eq $( type which &> /dev/null; echo ${?} ) ]]; then
        
        # programs that need to be checked for installation
        # [программы которые нужно проверить на установку]
        local arr=( "${@}" ) # local arr=( "${*}" )
        # echo ${arr[@]} # test 
        # echo ${#arr[@]} # test

        # programs to install
        # [программы которые нужно установить]
        local utils

        # checking the necessary installed utilities
        # [Проверка установки утилит]
        for app in ${arr[@]}; do
            # local app_path=$( which $app ) # test
            # echo $app_path # test

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

        # output [Вывод]
        if [[ 0 -ne ${#utils[@]} ]]; then
            # You need to install the following programs
            # [Нужно установить следующие программы]
            echo -e "you need to install the following programs:\n ${utils[@]}"
        else
            echo "all utils are installed"
        fi  

    else
        # output [Вывод]
        echo -e "you need to install the following programs:\n which"
    fi
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

# test
# utils=( max date find git gzip ls mkdir rm tar which mer )
# utils=( date find git gzip ls mkdir rm tar which )
# utils_test=$( check-install-utils "${utils[@]}" )
# if [[ "all utils are installed" != ${utils_test} ]]; then
#     echo "False"
# else
#     echo "True"
# fi
# ************************************************************************