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
    # connecting library functions
    # [подключаем функции-библиотеки]
    # ----------------------------------
    # if we are in the ../mersh/src/sum-in-math/ folder, then go to ../mersh/
    # [если находимся в папке ../mersh/src/sum-in-math/, то переходим в ../mersh/]
    # pwd # test
    local current_dir=`pwd`
    # echo "${current_dir##*/}" # test
    local bool="False"
    if [[ `pwd` != *"mersh" ]] || [[ `pwd` != *".mersh" ]]; then
        bool="True"
        # pwd # test
        cd ../../
        # pwd # test
    fi
    # ----------------------------------
    # connecting library functions
    # [подключаем функции-библиотеки]
    if [[ 0 -ne $( type check-install-utils &> /dev/null; echo ${?} ) ]]; then
        source check-install-utils.sh
    fi
    if [[ 0 -ne $( type set-in-math &> /dev/null; echo ${?} ) ]]; then
        source set-in-math.sh
    fi
    # ----------------------------------
    # return to the original directory if there was a transition to another directory
    # [возврат в первоначальную директорию, если был переход в другую директорию]
    if [[ 'True' == ${bool} ]]; then
        cd ${current_dir}
        bool="False"
        # echo "BOOL"
    fi
    # --------------------------------------------------------------------
    # СДЕЛАТЬ ПРОВЕРКУ НА УСТАНОВЛЕННОСТЬ УТИЛИТЫ BC
    # --------------------------------------------------------------------
    local arr=( ${@} ) # local arr=( ${*} )
    # echo "arr = ${arr[@]}" # test
    # echo "len arr = ${#arr[@]}" # test
    # ----------------------------------
    # a set of correct values to check the number
    # [набор правильных значений для проверки числа]
    local sequence_arr=( '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '.' )
    # ----------------------------------
    # СДЕЛАТЬ ПРОЕРКУ ЧТО ВСЕ ВВЕДЕННЫЕ ЭЛЕМЕНТЫ - ЭТО ЧИСЛА !!!!!!!!!!!!!!!!
    # ----------------------------------
    # the result of summing the numbers
    # [результат суммирования чисел]
    local sum=0
    # ----------------------------------
    # summation of elements
    # [суммирование элементов]
    for i in ${arr[@]}; do
        sum=`echo "${sum} + ${i}" | bc` # for float and int
        # let "sum += i" # for only int
        # (( sum += i )) # for only int
    done
    # ----------------------------------
    # if [[ 0 -eq "${#}" ]]; then
    if [[ 0 -ne ${#arr[@]} ]]; then
        echo ${sum}
    else
        # ПОДРЕДАКТИРОВАТЬ СПРАВКУ !!!
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
# sum-in-math "-5" "1.5" # test
sum-in-math "-1.5" "-1.5" # test
# ************************************************************************