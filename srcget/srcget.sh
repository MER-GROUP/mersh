#!/bin/bash
# ************************************************************************
# srcget

# Script for downloading and updating sources from github
# [Скрипт для скачивания и обновления исходников с github]
# ************************************************************************
# global variables
# [глобальные переменные]

# settings matrix
# [матрица настроек]
declare -A settings_arr
# ************************************************************************
# function settings_get

# get settings
# [получить настройки]
settings_get(){
    # --------------------------------------------------------------------
    # get settings
    # [получить настройки]
    for line in $( grep -v '^#' settings.sh ); do
        # echo $line
        IFS='=' read -a arr <<< $line
        settings_arr[${arr[0]}]=${arr[1]}
    done
    # --------------------------------------------------------------------
    # # show settings v1
    # # [показать настройки]
    # echo ${settings_arr[@]}

    # # show settings v2
    # # [показать настройки]
    # for line in ${settings_arr[@]}; do
    #     echo $line
    # done
    # --------------------------------------------------------------------
}
# ************************************************************************
# program logic
# [логика программы]

# get settings
# [получить настройки]
settings_get
# ************************************************************************
# tests
echo '###################tests###################'
echo path_src = ${settings_arr[path_src]}
echo file_links = ${settings_arr[file_links]}
echo hist_src = ${settings_arr[hist_src]}
echo '###########################################'
# ************************************************************************