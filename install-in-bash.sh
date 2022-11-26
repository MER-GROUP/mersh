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
    echo "${dirs_arr[@]}" # test
    # ----------------------------------
    # getting folders in a directory [получение файлов в директории]
    local files_arr=( $( ls -p | grep -v "/$" ) )
    echo "${files_arr[@]}" # test
    # ----------------------------------
    #
    # [если директория это обычный файл]
    if [[ -f "~/.mer-group/mersh" ]]; then
        #
        # [удалить файл и создать директорию]
        echo "удалить файл и создать директори"
    fi
    #
    # усли директория существует
    if [[ -d "~/.mer-group/mersh" ]]
        #
        # [то продолжить выполнение программы]
        echo "то продолжить выполнение программы"
    # 
    # [если файла или директория не существут]
    if [[ !( -e "~/.mer-group/mersh" ) ]]; then
        echo "test -e"
    fi
    # ----------------------------------
    
    # ----------------------------------

    # --------------------------------------------------------------------
}
# ************************************************************************
# installing scripts in bash
# [установка скриптов в bash]
install-in-bash
# ************************************************************************