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

    local set
    # set+=( 1 ); set+=( 2 ) # test
    # echo "set = ${set[@]}" # test
    # echo "len set = ${#set[@]}" # test

    local index=0
    # echo "index = ${index}" # test
    # let index++ # (( index++ )) # test
    # echo "index = ${index}" # test

    while [[ ${index} -ne ${#arr[@]} ]]; do
        # echo "index = ${index}" # test
        local bool=False

        for i in ${set[@]}; do
            if [[ ${arr[${index}]} -eq ${i} ]]; then
                bool=True
                break
            fi
        done

        if [[ 'False' == ${bool} ]]; then
            set+=( ${arr[${index}]} )
        fi

        let index++ # (( index++ ))
    done

    # echo "set = ${set[@]}" # test
    echo ${set[@]}
    # --------------------------------------------------------------------
}
# ************************************************************************
# tests

# set-in-math # test
# set-in-math "1" "2" "3" "1" "2" "3" "1" "2" "3" # test
# ************************************************************************