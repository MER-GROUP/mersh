#!/bin/bash
# ************************************************************************
# installing scripts in bash
# [установка скриптов в bash]
# ************************************************************************
# function install-in-bash

# installing scripts in bash
# [установка скриптов в bash]
install-in-bash(){ # NO args
    # --------------------------------------------------------------------
    # getting folders in a directory [получение папок в директории]
    local dirs_arr=( $( ls -p | grep "/$" ) )
    # echo "${dirs_arr[@]}" # test
    # ----------------------------------
    # getting folders in a directory [получение файлов в директории]
    local files_arr=( $( ls -p | grep -v "/$" ) )
    # echo "${files_arr[@]}" # test
    # ----------------------------------
    # if the file or directory does not exist
    # [если файл или директория не существут]
    # if [[ !( -e ~/.mer-group/mersh ) ]]; then
    if [[ !( -e "${HOME}/.mer-group/mersh" ) ]]; then
        # create a directory
        # [создать директорию]
        # mkdir -p ~/.mer-group/mersh/
        mkdir -p "${HOME}/.mer-group/mersh/"
        echo "crete -> ~/.mer-group/mersh/"

    # if the file is a regular file
    # [если файл это обычный файл]
    elif [[ -f "${HOME}/.mer-group/mersh" ]]; then
        # delete the file and create a directory
        # [удалить файл и создать директорию]
        # rm -rf ~/.mer-group/mersh
        rm -rf "${HOME}/.mer-group/mersh"
        echo "delete -> ~/.mer-group/mersh"
        # mkdir -p ~/.mer-group/mersh/
        mkdir -p "${HOME}/.mer-group/mersh/"
        echo "crete -> ~/.mer-group/mersh/"

    # if the file is a directory
    # [если файл это директория]
    elif [[ -d "${HOME}/.mer-group/mersh" ]]; then
        # then continue executing the program
        # [то продолжить выполнение программы]
        echo "ok -> ~/.mer-group/mersh/"
    fi 
    # ----------------------------------
    # copy the mersh scripts to the ~/.mer-group/mersh/ directory
    # [копируем скрипты mersh в директорию ~/.mer-group/mersh/]  
    echo "copy start -> ~/.mer-group/mersh/" 

    for dir in ${dirs_arr[@]}; do
        cp -ru ${dir} ${HOME}/.mer-group/mersh/
    done

    for file in ${files_arr[@]}; do
        cp -u ${file} ${HOME}/.mer-group/mersh/
    done

    echo "copy end -> ~/.mer-group/mersh/" 
    # ----------------------------------
    # if importing mersh scripts to bash was
    # [если импорта скриптов mersh в bash был]
    # if [[ '# mersh scripts' == $( grep "^# mersh scripts" ~/.bashrc | cut -d ' ' -f 1-3 ) ]]; then # or
    if [[ '# mersh scripts' == $( echo $( current_search=`grep "^# mersh scripts" ~/.bashrc`; echo "${current_search%[*}" ) ) ]]; then # or
        echo "bash -> setting up ок"
    else
        # if there was no import of mersh scripts into bash
        # [если импорта скриптов mersh в bash не было]
        # ----------------
        # importing mersh scripts to ~/.bashrc
        # [импорт скриптов mersh в ~/.bashrc]
        echo "" >> ${HOME}/.bashrc
        echo "# mersh scripts [сценарии mersh]" >> ${HOME}/.bashrc
        echo "current_dir=\`pwd\`" >> ${HOME}/.bashrc
        echo "cd ${HOME}/.mer-group/mersh/" >> ${HOME}/.bashrc
        echo "source import.sh" >> ${HOME}/.bashrc
        echo 'cd "${current_dir}"' >> ${HOME}/.bashrc
        echo "" >> ${HOME}/.bashrc
        echo "bash -> setting up ок"
        # ----------------
        # restarting bash
        # [перезапуск bash]
        source ${HOME}/.bashrc
        # ----------------
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# installing scripts in bash
# [установка скриптов в bash]
install-in-bash
# ************************************************************************