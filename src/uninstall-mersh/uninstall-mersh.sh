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
            # -------------------------------------------------------
            # getting the current directory
            # [получение текущей директории]
            local current_dir=`pwd`
            # -------------------------------------------------------
            # we determine the number of mersh scripts
            # [определяем количество скриптов mersh]
            # local script_count
            if [[ -e "${HOME}/.mer-group/mersh" ]] && [[ -d "${HOME}/.mer-group/mersh" ]]; then
                cd "${HOME}/.mer-group/mersh/"
                local script_count=( $( ls -p | grep -v "/$" ) )
                script_count="${#script_count[@]}"
                let "script_count -= 4" # or
                # (( script_count -= 4 )) # or
                # echo "${script_count}" # test
                cd "${current_dir}"
            fi
            # -------------------------------------------------------
            # removing all mersh scripts from a bash session
            # if the file or directory exists
            # [удаление всех скриптов mersh из сессии bash]
            # [если директория существут]
            if [[ -e "${HOME}/.mer-group/mersh" ]] && [[ -d "${HOME}/.mer-group/mersh" ]]; then
                local current_search=`grep "^# mersh vars" ~/.bashrc`
                current_search=`echo "${current_search%[*}"`
                if [[ '# mersh vars' == `echo ${current_search}` ]]; then
                    echo "ок -> mersh variables removed"
                else
                    echo "" >> ${HOME}/.bashrc
                    echo "# mersh vars [переменные mersh]" >> ${HOME}/.bashrc

                    cd "${HOME}/.mer-group/mersh/"
                    # pwd # test

                    # getting folders in a directory [получение файлов в директории]
                    files_arr=( $( ls -p | grep -v "/$" ) )
                    for lib in ${files_arr[@]}; do
                        if [[ 'import.sh' == ${lib} ]]; then
                            continue
                        elif [[ 'install-in-bash.sh' == ${lib} ]]; then
                            continue
                        elif [[ 'install-in-zsh.sh' == ${lib} ]]; then
                            continue
                        # elif [[ 'uninstall-mersh.sh' == ${lib} ]]; then
                        #     continue
                        elif [[ 'uninstall-mersh_TEMP.sh' == ${lib} ]]; then
                            continue
                        else
                            func=$( echo ${lib%.*} )
                            # echo "${func}" # test
                            echo "unset ${func}" >> ${HOME}/.bashrc
                        fi
                    done
                    cd "${current_dir}"

                    echo "" >> ${HOME}/.bashrc
                    echo "ок -> mersh variables removed"
                fi
            fi
            # -------------------------------------------------------
            # restarting bash
            # [перезапуск bash]
            source ${HOME}/.bashrc
            # -------------------------------------------------------



            # -------------------------------------------------------
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
# uninstall-mersh "start" # test
# uninstall-mersh "1" "2" # test
# uninstall-mersh "start" "2" # test
# uninstall-mersh "start" "start" # test
# ************************************************************************