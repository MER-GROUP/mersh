#!/bin/bash
# ************************************************************************
# sum-in-math

# The script creates a mathematical sum of numbers
# [Скрипт создаёт математическую сумму чисел]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function sum-in-math

# creating a mathematical sum
# [создание математической суммы]
sum-in-math(){ # args: number_1 ... number_N
    # --------------------------------------------------------------------
    local arr=( ${@} ) # local arr=( ${*} )
    # echo "arr = ${arr[@]}" # test
    # echo "len arr = ${#arr[@]}" # test
    # ----------------------------------
    local sum=0
    # ----------------------------------
    # СДЕЛАТЬ ПРОЕРКУ ЧТО ВСЕ ВВЕДЕННЫЕ ЭЛЕМЕНТЫ - ЭТО ЧИСЛА !!!!!!!!!!!!!!!!
    # ----------------------------------
    for i in ${arr[@]}; do
        let "sum += i"
        # (( sum += i )) 
    done
    # ----------------------------------
    # if [[ 0 -eq "${#}" ]]; then
    if [[ 0 -ne ${#arr[@]} ]]; then
        echo ${sum}
    else
        echo "|-ENG-HELP----------------------------------------------------|"
        echo "|  help          : sum-in-math - creates a mathematical sum   |"
        echo "|  usage         : sum-in-math [ sequence of numbers ]        |"
        echo "|  example       : sum-in-math 1 2 3                          |"
        echo "|  output        : 6                                          |"
        echo "|  example       : sum-in-math -5 -5                          |"
        echo "|  output        : -10                                        |"
        echo "|-RUS-HELP----------------------------------------------------|"
        echo "|  помощь        : sum-in-math - создаёт математическую сумму |"
        echo "|  использование : sum-in-math [ последовательность чисел ]   |"
        echo "|  пример        : sum-in-math 1 2 3                          |"
        echo "|  вывод         : 6                                          |"
        echo "|  пример        : sum-in-math -5 -5                          |"
        echo "|  вывод         : -10                                        |"
        echo "|-END---------------------------------------------------------|"
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f sum-in-math
# ************************************************************************
# tests

# sum-in-math # test
# sum-in-math "1" "2" "3" # test
# sum-in-math "1" "2" "3" "-1" # test
# sum-in-math "1" "2" "3" "-1" "-5" # test
# sum-in-math "1" "2" "3" "-1" "-5" "-5" # test
# sum-in-math "-5" "-5" # test
# ************************************************************************