#!/bin/bash
# ************************************************************************
# deleting all mersh scripts
# [удаление всех скриптов mersh]
# ************************************************************************
# function uninstall-mersh

# deleting all mersh scripts
# [удаление всех скриптов mersh]
uninstall-mersh(){ # NO args
    # --------------------------------------------------------------------
    # getting the current directory
    # [получение текущей директории]
    current_dir=`pwd`
    # ----------------------------------
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
    cd "${current_dir}"
    # ----------------------------------
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
    while IFS= read -r line; do
        # echo "${i}" # test
        if [[ '# mersh scripts [сценарии mersh]' ==  "${line}" ]]; then
            let i++ # (( i++ ))
            continue
        # elif [[ ${i} -ge 1 ]] && [[ ${i} -le 4 ]]; then # or
        elif [[ 0 -lt ${i} ]] && [[ 5 -gt ${i} ]]; then # or
            let i++ # (( i++ ))
            continue
        # deleting empty lines after deleted mersh settings
        # [удаляем пустые строки после удаленных настроек mersh]
        elif [[ 5 -le ${i} ]] && [[ ${n} == ${line} ]] && [[ 'True' == ${bool} ]]; then
            let i++ # (( i++ ))
            continue
        elif [[ 5 -le ${i} ]] && [[ ${n} != ${line} ]]; then
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
    # ----------------------------------
    # restarting bash
    # [перезапуск bash]
    source ${HOME}/.bashrc
    # --------------------------------------------------------------------
}
# ************************************************************************
# deleting all mersh scripts
# [удаление всех скриптов mersh]
uninstall-mersh
# ************************************************************************