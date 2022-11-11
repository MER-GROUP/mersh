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
    # writing all arguments to an array
    # [записываем все аргументы в массив]
    local arr=( ${@} ) # local arr=( ${*} )
    # echo "arr = ${arr[@]}" # test
    # echo "len arr = ${#arr[@]}" # test
    # ----------------------------------
    # list of scripts [список скриптов]
    local scripts
    scripts+=( "\b|                      check-install-utils                          |\n"  )
    scripts+=( "\b|                      mersh                                        |\n"  )
    scripts+=( "\b|                      set-in-math                                  |\n"  )
    scripts+=( "\b|                      src-get-from-github                          |\n"  )
    scripts+=( "\b|                      sum-in-math                                  |"  )
    # ----------------------------------
    # variable for help output
    # [переменная для вывода справки]
    local check=True
    # ----------------------------------
    # show help for scripts that are part of mersh
    # [показать справки скриптов которые входят в состав mersh]
    if [[ 0 -ne ${#arr[@]} ]]; then
        # checking that the arguments are mersh scripts
        # [проверка что аргументы это скрипты mersh]
        for script in "${arr[@]}"; do
            # echo "${script}" # test
            # echo "${scripts[@]}" # test
            # if [[ "${scripts[@]}" != *"${script}"* ]]; then # or
            if [[ "${scripts[@]}" != *${script}* ]]; then # or
                check=False
                break
            fi
        done
        # ----------------
        # if all arguments are correct, then show script help
        # [если все агументы коректны, то показать справки скриптов]
        if [[ 'True' == "${check}"  ]]; then
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
            for lib in "${arr[@]}"; do
                if [[ 0 -ne $( type "${lib}" &> /dev/null; echo ${?} ) ]]; then
                    source "${lib}.sh"
                fi
            done
            # ----------------------------------
            # return to the original directory if there was a transition to another directory
            # [возврат в первоначальную директорию, если был переход в другую директорию]
            if [[ 'True' == ${bool} ]]; then
                cd ${current_dir}
                bool="False"
                # echo "BOOL"
            fi
            # --------------------------------------------------------------------
            # showing help on scripts
            # [показываем справки по скриптам]
            for doc in "${arr[@]}"; do
                ${doc}
            done
            # --------------------------------------------------------------------
        fi
        # ----------------
    fi
    # ----------------------------------
    # show help if if there are no arguments or if invalid arguments
    # [показать справку если если нет аргументов или если неверные аргументы]
    if [[ 'False' == "${check}" ]] || [[ 0 -eq ${#arr[@]} ]]; then
        echo "|-ENG-HELP----------------------------------------------------------|"
        echo "|  help          : mersh - a short guide to all scripts             |"
        echo "|  usage         : mersh [ sequence of scripts or none ]            |"
        echo "|  example       : mersh                                            |"
        echo "|  output        : ... output of this help ...                      |"
        echo "|  example       : mersh src-get-from-github sum-in-math            |"
        echo "|  output        : ... output of help for scripts ...               |"
        echo "|-RUS-HELP----------------------------------------------------------|"
        echo "|  помощь        : mersh - краткое руководство по всем скриптам     |"
        echo "|  использование : mersh [ последовательность элеменов или ничего ] |"
        echo "|  пример        : mersh                                            |"
        echo "|  вывод         : ... вывод данной справки ...                     |"
        echo "|  пример        : mersh src-get-from-github sum-in-math            |"
        echo "|  вывод         : ... вывод справок по скриптам ...                |"
        echo "|-END---------------------------------------------------------------|"
        echo "|                       Scripts [скрипты]:                          |"
        echo "|                      --------------------                         |"
        echo -e "${scripts[@]}"
        echo "|-------------------------------------------------------------------|"
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
# mersh "red" "alert" "nonescript" # test
# mersh "mersh" "alert" "set-in-math" # test
# mersh "mersh" "sum-in-math" "set-in-math" # test
# ************************************************************************