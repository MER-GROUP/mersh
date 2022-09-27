#!/bin/bash

# srcget
# Script for downloading and updating sources from github
# [Скрипт для скачивания и обновления исходников с github]

# settings matrix
# [матрица настроек]
declare -A settings_arr

# get settings
# [получить настройки]
for line in $( grep -v '^#' settings.sh ); do
    echo $line
    IFS='=' read -a arr <<< $line
    settings_arr[${arr[0]}]=${arr[1]}
done

# # show settings v1
# # [показать настройки]
# echo ${settings_arr[@]}

# # show settings v2
# # [показать настройки]
# for line in ${settings_arr[@]}; do
#     echo $line
# done