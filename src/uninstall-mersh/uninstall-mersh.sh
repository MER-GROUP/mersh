#!/bin/bash
# ************************************************************************
# uninstall-mersh

# Deleting all mersh scripts
# [Удаление всех скриптов mersh]

# Script implementation - Max Romanenko (Red Alert) - 2023.
# Реализация скрипта - Макс Романенко (Red Alert) - 2023г.
# ************************************************************************
# function uninstall-mersh

# Deleting all mersh scripts
# [Удаление всех скриптов mersh]
uninstall-mersh(){ # NO args
    # --------------------------------------------------------------------
    # getting function arguments
    # [получение аргументов функции]
    local arr=( ${@} ) # local arr=( ${*} )
    # echo "arr = ${arr[@]}" # test
    # echo "len arr = ${#arr[@]}" # test
    # --------------------------------------------------------------------
    # execute if there are arguments to the function
    # [выполнить если есть аргументы функции]
    if [[ 0 -ne ${#arr[@]} ]]; then
        # execute if the function argument is == start
        # [выполнить если аргумент функции == start]
        if [[ 'start' == ${arr} ]] && [[ 1 -eq ${#arr[@]} ]]; then
            echo "2222222222222"
        else
            echo "!!!!!!!!!! SPRAVKA !!!!!!!!!!"
        fi
    # --------------------------------------------------------------------
    # program help [справка программы]
    else
        echo "!!!!!!!!!! SPRAVKA !!!!!!!!!!"
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f uninstall-mersh
# ************************************************************************
# tests

# uninstall-mersh # test
uninstall-mersh "start" # test
# uninstall-mersh "1" "2" # test
# uninstall-mersh "start" "2" # test
# uninstall-mersh "start" "start" # test
# ************************************************************************