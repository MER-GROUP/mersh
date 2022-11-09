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
        # checking that all the entered elements are numbers (5, 1.5, -2, -3.67, etc.)
        # [проверка что все введенные элементы это числа (5, 1.5, -2, -3.67 и т.д.)]
        for digit in ${arr[@]}; do
            local start=0
            local next=1
            local len=${#digit}
            # echo "len = ${len}"
            local dots=0
            local minus=0
            # ----------------------------------
            while [[ ${start} -ne ${len} ]]; do
                # info
                # string indexing: ${string:0:1} is the null character, ${string:1:1} is the first character
                # string indexing: ${string:2:1} is the second character and so on
                # ${string:2:1} - first argument 2 - show characters from the second inclusive
                # ${string:2:1} - second argument 1 - showing the quantity from the second character
                # [информация]
                # [индексация строк: ${string:0:1}-нулевой символ, ${string:1:1}-первый символ]
                # [индексация строк: ${string:2:1}-второй символ и так далее]
                # [${string:2:1} - первый аргумент 2 - показать сивволы от второго включительно]
                # [${string:2:1} - второй аргумент 1 - показ количества от второго символа]
                # ------------------------------
                # getting a symbol
                # [получение символа]
                # local char=${digit[@]:${start}:${next}} # or
                # local char=${digit[0]:${start}:${next}} # or
                local char=${digit:${start}:${next}} # or
                # ------------------------------
                # echo "char = ${char}" # test
                # echo "start = ${start}" # test
                # echo "next = ${next}" # test
                # echo "len = ${len}" # test
                # echo "------------" # test
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
                    # (( start += 1 ))
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
                # the full output of the number is correct: -0.5, 0.5; incorrect: -.5, .5
                # [полный вывод числа правильно: -0.5, 0.5; неправильно: -.5, .5]
                # СДЕАЛТЬ ПРАВИЛЬНЫЕ ВЫВОД (НЕ: -.5 А: -0.5) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 111
                if [[ "${sum}" == "-."* ]]; then
                    echo "1111111111111"
                elif [[ "${sum}" == "."* ]]; then
                    echo "2222222222222"
                else
                    echo ${sum}
                fi
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
# sum-in-math "1" "5.67" # test
# sum-in-math "1" "-5.67" # test
# sum-in-math "1" "--5.67" # test for error
# sum-in-math "1" "-5.67-" # test for error
# sum-in-math "1" "-5.67." # test for error
# sum-in-math "1" "-5.6.7" # test for error
# sum-in-math "1" "-5..67" # test for error
# sum-in-math "1" "..67" # test for error
# sum-in-math "1" ".67" # test
# sum-in-math "-1" "-.67" # test
sum-in-math "1" "-1.5" # test
# ************************************************************************