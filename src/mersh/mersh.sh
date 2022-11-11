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
        if [[ 'True' == "${check}"  ]]; then
            echo "1111111111111111111111111111111111"
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
mersh "mersh" "sum-in-math" "set-in-math" # test
# ************************************************************************