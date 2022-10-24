#!/bin/bash
# ************************************************************************
# set-in-math

# The script creates a mathematical set of different elements
# [Скрипт создаёт математическое множество из разных элементов]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function set-in-math

# creating a mathematical set
# [создание математического множества]
set-in-math(){ # args: element_1 ... element_N
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
        echo "|  help          : set-in-math - print a mathematical set          |"
        echo "|  usage         : set-in-math [ sequence of elements ]            |"
        echo "|  example       : set-in-math 1 2 3 2 3 4 3 4 5                   |"
        echo "|  output        : 1 2 3 4 5                                       |"
        echo "|  example       : set-in-math one two one three                   |"
        echo "|  output        : one two three                                   |"
        echo "|-RUS-HELP---------------------------------------------------------|"
        echo "|  помощь        : set-in-math - печатает математическое множество |"
        echo "|  использование : set-in-math [ последовательность элеменов ]     |"
        echo "|  пример        : set-in-math 1 2 3 2 3 4 3 4 5                   |"
        echo "|  вывод         : 1 2 3 4 5                                       |"
        echo "|  пример        : set-in-math один два один три                   |"
        echo "|  вывод         : один два три                                    |"
        echo "|-END--------------------------------------------------------------|"
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f set-in-math
# ************************************************************************
# tests

# set-in-math # test
# set-in-math "1" "2" "3" "1" "2" "3" "1" "2" "3" # test
# set-in-math "1" "2" "3" "1" "2" "1" "2" "3" "4" "5" "6" # test
# ************************************************************************