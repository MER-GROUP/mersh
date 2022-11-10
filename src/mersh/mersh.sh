#!/bin/bash
# ************************************************************************
# mersh

# mersh is a quick reference for all scripts
# [mersh это краткая справка по всем скриптам]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function mersh

# mersh is a quick reference for all scripts
# [mersh это краткая справка по всем скриптам]
mersh(){ # args: script_1 ... script_N
    # --------------------------------------------------------------------
    local arr=( ${@} ) # local arr=( ${*} )
    # echo "arr = ${arr[@]}" # test
    # echo "len arr = ${#arr[@]}" # test
    # ----------------------------------
    local set
    # set+=( 1 ); set+=( 2 ) # test
    # echo "set = ${set[@]}" # test
    # echo "len set = ${#set[@]}" # test
    # ----------------------------------
    local index=0
    # echo "index = ${index}" # test
    # let index++ # (( index++ )) # test
    # echo "index = ${index}" # test
    # ----------------------------------
    while [[ ${index} -ne ${#arr[@]} ]]; do
        # echo "index = ${index}" # test
        local bool=True

        for i in ${set[@]}; do
            # if [[ ${arr[${index}]} -eq ${i} ]]; then # for int [для целых чисел]
            if [[ ${arr[${index}]} == ${i} ]]; then # for str [для строк]
                bool=False
                break
            fi
        done

        if [[ 'True' == ${bool} ]]; then
            set+=( ${arr[${index}]} )
        fi

        let index++ # (( index++ ))
    done
    # ----------------------------------
    # echo "set = ${set[@]}" # test
    if [[ 0 -ne ${#set[@]} ]]; then
        echo ${set[@]}
    else
        echo "|-ENG-HELP---------------------------------------------------------|"
        echo "|  help          : mersh - print a mathematical set          |"
        echo "|  usage         : mersh [ sequence of elements ]            |"
        echo "|  example       : mersh 1 2 3 2 3 4 3 4 5                   |"
        echo "|  output        : 1 2 3 4 5                                       |"
        echo "|  example       : mersh one two one three                   |"
        echo "|  output        : one two three                                   |"
        echo "|-RUS-HELP---------------------------------------------------------|"
        echo "|  помощь        : mersh - печатает математическое множество |"
        echo "|  использование : mersh [ последовательность элеменов ]     |"
        echo "|  пример        : mersh 1 2 3 2 3 4 3 4 5                   |"
        echo "|  вывод         : 1 2 3 4 5                                       |"
        echo "|  пример        : mersh один два один три                   |"
        echo "|  вывод         : один два три                                    |"
        echo "|-END--------------------------------------------------------------|"
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f mersh
# ************************************************************************
# tests

# mersh # test
# mersh "1" "2" "3" "1" "2" "3" "1" "2" "3" # test
# mersh "1" "2" "3" "1" "2" "1" "2" "3" "4" "5" "6" # test
# ************************************************************************