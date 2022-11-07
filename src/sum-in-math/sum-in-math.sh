#!/bin/bash
# ************************************************************************
# sum-in-math

# The script creates a mathematical sum of numbers
# [Скрипт создаёт математическую сумму чисел]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# function help_sum_in_math

# program help [справка программы]
help_sum_in_math(){ # NO args
    # --------------------------------------------------------------------
    # program help [справка программы]
    echo "|-ENG-HELP----------------------------------------------------|"
    echo "|  help          : sum-in-math - creates a mathematical sum   |"
    echo "|  usage         : sum-in-math [ sequence of numbers ]        |"
    echo "|  example       : sum-in-math 1 2 3                          |"
    echo "|  output        : 6                                          |"
    echo "|  example       : sum-in-math -5 1.5                         |"
    echo "|  output        : -3.5                                       |"
    echo "|-RUS-HELP----------------------------------------------------|"
    echo "|  помощь        : sum-in-math - создаёт математическую сумму |"
    echo "|  использование : sum-in-math [ последовательность чисел ]   |"
    echo "|  пример        : sum-in-math 1 2 3                          |"
    echo "|  вывод         : 6                                          |"
    echo "|  пример        : sum-in-math -5 1.5                         |"
    echo "|  вывод         : -3.5                                       |"
    echo "|-END---------------------------------------------------------|"
    # --------------------------------------------------------------------
}
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
    # ----------------------------------
    # return to the original directory if there was a transition to another directory
    # [возврат в первоначальную директорию, если был переход в другую директорию]
    if [[ 'True' == ${bool} ]]; then
        cd ${current_dir}
        bool="False"
        # echo "BOOL"
    fi
    # --------------------------------------------------------------------
    # variable to interrupt the program
    # [переменная для прерывания программы]
    local next_prog=True
    # ----------------------------------
    # checking the installation of the utility - bc
    # [проверка установки утилиты bc]
    # local utility=$( check-install-utils "redalert" ) # test
    local utility=$( check-install-utils "bc" )
    if [[ 'all utils are installed' != "${utility}" ]]; then
        echo "${utility}"
        next_prog=False
    fi
    # --------------------------------------------------------------------
    # if the bc utility is installed, then continue executing the program
    # [если утилита bc установлена, то продолжить выполнение программы]
    if [[ 'True' == "${next_prog}" ]]; then
        # ----------------------------------
        # array of integers or float numbers
        # [массив целых или дробных чисел]
        local arr=( ${@} ) # local arr=( ${*} )
        # echo "arr = ${arr[@]}" # test
        # echo "len arr = ${#arr[@]}" # test
        # ----------------------------------
        # a set of correct values to check the number
        # [набор правильных значений для проверки числа]
        local sequence_str='-0123456789'
        # ----------------------------------------------------------------
        # ЧЕТО НЕ ТО !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 111
        # checking that all the entered elements are numbers (5, 1.5, -2, -3.67, etc.)
        # [проверка что все введенные элементы это числа (5, 1.5, -2, -3.67 и т.д.)]
        for digit in ${arr[@]}; do
            local start=0
            local next=1
            local next_bool=False
            local len=${#digit}
            # echo "len = ${len}"
            local dots=0
            local minus=0
            # ---------------------------------
                echo "char 0 = ${char}" # test
                echo "start 0 = ${start}" # test
                echo "next 0 = ${next}" # test
                echo "len 0 = ${len}" # test
                echo "------------" # test
            # ----------------------------------
            while [[ ${start} -ne ${len} ]]; do
                # string indexing: 0:0-empty, 0:1-null character
                # indexing rows: 1:1 is the first character, 2:2 is the second character, and so on
                # [индексация строк: 0:0-пустота, 0:1-нулевой символ]
                # [индексация строк: 1:1-первый символ, 2:2-второй символ и так далее]
                if [[ 'True' == "${next_bool}" ]]; then
                        let "next -= 1"
                        # (( next -= 1 ))
                        next_bool=None
                    fi
                # ------------------------------
                # getting a symbol
                # [получение символа]
                # local char=${digit[0]:${start}:${next}} # or
                local char=${digit:${start}:${next}} # or
                # ------------------------------
                echo "char = ${char}" # test
                echo "start = ${start}" # test
                echo "next = ${next}" # test
                echo "len = ${len}" # test
                echo "------------" # test
                # ------------------------------
                # we fix two points in the number
                # [фиксируем в числе две точки]
                if [[ '.' == "${char}" ]]; then
                    let "dots += 1"
                    # (( dots += 1 ))
                    if [[ 2 -eq ${dots} ]]; then
                        next_prog=False
                        break
                    fi
                fi
                # ------------------------------
                # we fix two minuses in the number
                # [фиксируем в числе два минуса]
                if [[ '-' == "${char}" ]]; then
                    let "minus += 1"
                    # (( minus += 1 ))
                    if [[ 2 -eq ${minus} ]]; then
                        next_prog=False
                        break
                    fi
                fi
                # ------------------------------
                # if the symbol is a number then we continue the program
                # [если символ число то продолжаем программу]
                if [[ "${char}" == *"${i}"* ]]; then
                    let "start += 1"
                    let "next += 1"
                    # (( start += 1 ))
                    # (( next += 1 ))
                    if [[ 'None' != "${next_bool}" ]]; then
                        next_bool=True
                    fi
                    continue
                # otherwise, we exit the program
                # [иначе выходим из программы]
                else
                    next_prog=False
                    break
                fi  
                # ------------------------------        
            done
            # ----------------------------------
            # exit the program if the character is not a number
            # [выход из программы если символ не число]
            if [[ 'False' == "${next_prog}" ]]; then
                break
            fi
            # ----------------------------------
        done
        # ----------------------------------------------------------------
        # if numbers are entered, then continue executing the program
        # [если введены числа, то продолжить выполнение программы]
        if [[ 'True' == "${next_prog}" ]]; then
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
            # show the sum of the numbers
            # [показать сумму чисел]
            # if [[ 0 -eq "${#}" ]]; then
            if [[ 0 -ne ${#arr[@]} ]]; then
                # СДЕАЛТЬ ПРАВИЛЬНЫЕ ВЫВОД (НЕ: -.5 А: -0.5) !!!!!!!!!!!!!!!!!!!!!!!!!!! 222
                echo ${sum}
            # ----------------------------------
            # if the parameter is incorrect then show help
            # [если неверный параметр то показать справку]
            else
                # program help [справка программы]
                help_sum_in_math
            fi
        # ----------------------------------------------------------------
        # otherwise show the help
        # [иначе показать справку]
        else
            # program help [справка программы]
            help_sum_in_math
        fi
        # ----------------------------------------------------------------
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
# sum-in-math "-1.5" "-1.5" # test
# sum-in-math "1" "-2.5" # test
# sum-in-math "1" "5" # test
# sum-in-math "1" "1.5" # test
# sum-in-math "1" "567" # test
sum-in-math "1" "5.67" # test
# sum-in-math "1" "-5.67" # test
# sum-in-math "1" "--5.67" # test for error
# sum-in-math "1" "-5.67-" # test for error

# sum-in-math "1" "-1.5" # test !!!!!!!
# ************************************************************************