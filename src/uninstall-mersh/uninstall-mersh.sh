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
    # getting the current directory
    # [получение текущей директории]
    local current_dir=`pwd`
    # --------------------------------------------------------------------
    # execute if there are arguments to the function
    # [выполнить если есть аргументы функции]
    if [[ 0 -ne ${#arr[@]} ]]; then
        # execute if the function argument is == start
        # [выполнить если аргумент функции == start]
        if [[ 'start' == ${arr} ]] && [[ 1 -eq ${#arr[@]} ]]; then           
            # -------------------------------------------------------
            # we determine the number of mersh scripts
            # [определяем количество скриптов mersh]
            # local script_count
            if [[ -e "${HOME}/.mer-group/mersh" ]] && [[ -d "${HOME}/.mer-group/mersh" ]]; then
                cd "${HOME}/.mer-group/mersh/"
                local script_count=( $( ls -p | grep -v "/$" ) )
                script_count="${#script_count[@]}"
                let "script_count -= 3" # or
                # (( script_count -= 3 )) # or
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
            #  deleting settings from the ~/.bashrc file
            # [удаление настроек из файла ~/.bashrc]
            # ----------------
            # copy the ~/.bashrc file to the array
            # we do not copy the mersh settings from the ~/.bashrc file
            # [копируем файл ~/.bashrc в массив]
            # [настройки mersh из файла ~/.bashrc не копируем]
            local bashrc_arr 
            local file_path="${HOME}/.bashrc"
            local i=0
            local n=`echo -e "\n"`
            local bool='True'
            # echo "${script_count}" # test
            while IFS= read -r line; do
                # echo "${i}" # test
                if [[ '# mersh vars [переменные mersh]' ==  "${line}" ]]; then
                    let i++ # (( i++ ))
                    continue
                elif [[ ${i} -ge 1 ]] && [[ ${i} -le ${script_count} ]]; then
                # elif [[ 0 -lt ${i} ]] && [[ ${script_count} -gt ${i} ]]; then # need minus one
                    let i++ # (( i++ ))
                    continue
                # deleting empty lines after deleted mersh settings
                # [удаляем пустые строки после удаленных настроек mersh]
                elif [[ ${script_count} -le ${i} ]] && [[ ${n} == ${line} ]] && [[ 'True' == ${bool} ]]; then
                    let i++ # (( i++ ))
                    continue
                elif [[ ${script_count} -le ${i} ]] && [[ ${n} != ${line} ]]; then
                    bool='False'
                fi

                bashrc_arr+=( "$line" )
            done < "${file_path}"
            # echo "${bashrc_arr[@]}"
            # ----------------
            # overwrite the ~/.bashrc file
            # [перезаписать файл ~/.bashrc]
            # --------
            # bad version
            # [плохая версия]
            # echo "" > "${file_path}"
            # for line in "${bashrc_arr[@]}"; do
            #     echo "${line}" >> "${file_path}"
            # done
            # --------
            # good version
            # [хорошая версия]
            i=0
            for line in "${bashrc_arr[@]}"; do
                if [[ 0 -eq ${i} ]]; then
                    echo "${line}" > "${file_path}"
                    let i++ # (( i++ ))
                else
                    echo "${line}" >> "${file_path}"
                fi
            done
            # -------------------------------------------------------
            # deleting all mersh scripts
            # if the file or directory exists
            # [удаление всех скриптов mersh]
            # [если директория существут]
            if [[ -e "${HOME}/.mer-group" ]] && [[ -d "${HOME}/.mer-group" ]]; then
                # go to the directory [перейти в директорию]
                cd "${HOME}/.mer-group"
                # getting folders in a directory [получение папок в директории]
                local dirs_arr=( $( ls -p | grep "/$" ) )
                # echo "${dirs_arr[@]}" # test
                # ----------------
                # if there are many folders in the mer-group folder
                # then delete the mersh folder with all the contents
                # [если в папке mer-group много папок]
                # [то удалить папку mersh со всем содержимым]
                if [[ 1 -lt ${#dirs_arr[@]} ]]; then
                    # echo "${dirs_arr}" # test
                    if [[ -e "${HOME}/.mer-group/mersh" ]] && [[ -d "${HOME}/.mer-group/mersh" ]]; then
                        rm -rf "${HOME}/.mer-group/mersh"
                    fi
                # ----------------
                # if there is only one mersh folder in the mer-group folder
                # then delete the mer-group folder with all the contents
                # [если в папке mer-group только одна папка mersh]
                # [то удалить папку mer-group со всем содержимым]
                elif  [[ 1 -eq ${#dirs_arr[@]} ]] && [[ 'mersh/' == ${dirs_arr}  ]]; then
                    # echo "${dirs_arr}" # test
                    cd ..
                    rm -rf "${HOME}/.mer-group"
                # ----------------
                # if mersh is deleted in the mer-group folder, but there are other folders, then we do not delete mer-group
                # [если в папке mer-group удален mersh, но есть другие папки, то mer-group не удаляем]
                elif  [[ 1 -eq ${#dirs_arr[@]} ]] && [[ 'mersh/' != ${dirs_arr}  ]]; then
                    # echo "${dirs_arr}" # test
                    cd ..
                # ----------------
                # if the mer-group folder is empty, then delete it
                # [если папка mer-group пустая то удалить её]
                else
                    # echo "${dirs_arr}" # test
                    cd ..
                    rm -rf "${HOME}/.mer-group"
                fi
                # ----------------
                echo "ok -> mersh scripts have been removed"
                # ----------------
            else
                echo "ok -> mersh scripts have been removed"
            fi
            # ----------------------------------
            # return to the original directory
            # [возврат в первоначальную директорию]
            # echo "${current_dir}" # test
            cd "${current_dir}"
            # # -------------------------------------------------------
            # #  deleting settings from the ~/.bashrc file
            # # [удаление настроек из файла ~/.bashrc]
            # # ----------------
            # # copy the ~/.bashrc file to the array
            # # we do not copy the mersh settings from the ~/.bashrc file
            # # [копируем файл ~/.bashrc в массив]
            # # [настройки mersh из файла ~/.bashrc не копируем]
            # local bashrc_arr 
            # local file_path="${HOME}/.bashrc"
            # local count_line_bash=5
            # local i=0
            # local n=`echo -e "\n"`
            # local bool='True'
            # while IFS= read -r line; do
            #     # echo "${i}" # test
            #     if [[ '# mersh scripts [сценарии mersh]' ==  "${line}" ]]; then
            #         let i++ # (( i++ ))
            #         continue
            #     # elif [[ ${i} -ge 1 ]] && [[ ${i} -le 4 ]]; then # or
            #     # elif [[ 0 -lt ${i} ]] && [[ 5 -gt ${i} ]]; then # or
            #     elif [[ 0 -lt ${i} ]] && [[ ${count_line_bash} -gt ${i} ]]; then # or
            #         let i++ # (( i++ ))
            #         continue
            #     # deleting empty lines after deleted mersh settings
            #     # [удаляем пустые строки после удаленных настроек mersh]
            #     # elif [[ 5 -le ${i} ]] && [[ ${n} == ${line} ]] && [[ 'True' == ${bool} ]]; then
            #     elif [[ ${count_line_bash} -le ${i} ]] && [[ ${n} == ${line} ]] && [[ 'True' == ${bool} ]]; then
            #         let i++ # (( i++ ))
            #         continue
            #     # elif [[ 5 -le ${i} ]] && [[ ${n} != ${line} ]]; then
            #     elif [[ ${count_line_bash} -le ${i} ]] && [[ ${n} != ${line} ]]; then
            #         bool='False'
            #     fi

            #     bashrc_arr+=( "$line" )
            # done < "${file_path}"
            # # echo "${bashrc_arr[@]}"
            # # ----------------
            # # overwrite the ~/.bashrc file
            # # [перезаписать файл ~/.bashrc]
            # # --------
            # # bad version
            # # [плохая версия]
            # # echo "" > "${file_path}"
            # # for line in "${bashrc_arr[@]}"; do
            # #     echo "${line}" >> "${file_path}"
            # # done
            # # --------
            # # good version
            # # [хорошая версия]
            # i=0
            # for line in "${bashrc_arr[@]}"; do
            #     if [[ 0 -eq ${i} ]]; then
            #         echo "${line}" > "${file_path}"
            #         let i++ # (( i++ ))
            #     else
            #         echo "${line}" >> "${file_path}"
            #     fi
            # done
            # # -------------------------------------------------------
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