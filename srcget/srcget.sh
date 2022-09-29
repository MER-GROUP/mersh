#!/bin/bash
# ************************************************************************
# srcget

# Script for downloading and updating sources from github
# [Скрипт для скачивания и обновления исходников с github]

# Script implementation - Max Romanenko (Red Alert) - 2022.
# Реализация скрипта - Макс Романенко (Red Alert) - 2022г.
# ************************************************************************
# global variables [глобальные переменные]

# settings file [файл настроек]
file_settings=./settings.sh

# link file [файл ссылок]
# file_links=./links.sh
file_links=$( v=$( grep -e 'file_links' ${file_settings} ); echo ${v#*=} )

# settings matrix [матрица настроек]
declare -A settings_arr

# link matrix [матрица ссылок]
links_arr=( $( grep -v '^#' ${file_links} ) )

# name of the programs to check for installation 
# [название программ для проверки на установку]
utils=( git tar mkdir rm which )
# ************************************************************************
# function check_core_utils

# checking the necessary installed utilities
# [проверка необходимых установленных утилит]
check_core_utils(){ # args: program_1 ... program_N
    # --------------------------------------------------------------------
    # required installed programs [необходимые установленные программы]
    # arr=( git tar mer) # for test [для тестов]
    # arr=( git tar which) # for test [для тестов]
    arr=( "${*}" )
    # echo ${arr[@]}

    # checking the necessary installed utilities
    # [проверка необходимых установленных утилит]
    for app in ${arr[@]}; do
        # # test [тест]
        # app_path=$( which $app )
        # echo $app_path

        # 0 - the program is installed, 1 and more - not
        # [0 - программа установленна, 1 и больше - нет]
        which ${app} &> /dev/null
        bool=$( echo  ${?} )
        if [ 0 -ne ${bool} ]; then
            echo "You need to install the ${app} to continue"
            exit ${bool}
        fi
    done
    # --------------------------------------------------------------------
}
# ************************************************************************
# function settings_get

# get settings [получить настройки]
settings_get(){ # args: file_path
    # --------------------------------------------------------------------
    # the path of the settings file [путь файла с настройками]
    file_path=${1}
    # get settings [получить настройки]
    for line in $( grep -v '^#' $file_path ); do
        # echo $line
        IFS='=' read -a arr <<< ${line}
        settings_arr[${arr[0]}]=${arr[1]}
    done
    # --------------------------------------------------------------------
    # # show settings v1 [показать настройки]
    # echo ${settings_arr[@]}

    # # show settings v2 [показать настройки]
    # for line in ${settings_arr[@]}; do
    #     echo ${line}
    # done
    # --------------------------------------------------------------------
}
# ************************************************************************
# function check_path

# checking the existence of a directory [проверка существования директории]
check_path(){ # args: path
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	path=${1}

    # # if the directory is a file then exit the program
    # # otherwise if the path does not exist then create a directory
    # # [если директория это файл то выйти из программы]
    # # [иначе если пути не существует то создать директорию]
    # if [[ ! -d ${path} ]]; then
    #     echo "${path} is not dir, exiting"
    #     exit 1
    # elif [[ ! -e ${path} ]]; then
    #     echo "Dir is not exist, creating ${path}"
    #     mkdir -p ${path}
    # fi

    # if the directory is a file then delete the file and create a directory
    # [если директория это файл то удалить файл и создать директорию]
	if [[ ! -e ${path} ]]; then
        echo "Dir is not exist, creating ${path}"
        if [[ ! -d ${path} ]]; then
            let "ind = ${#path[0]} - 1"
            # echo "file = ${path[@]:0:${ind}}"
            file=${path[@]:0:${ind}}
            # rm -rf ${path}
            rm ${file} &> /dev/null
        fi
        mkdir -p ${path} &> /dev/null
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# function src_get

# get sources from github [получить исходники с github]
src_get(){ # args: path, links
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	path=${1}
    # link matrix [матрица ссылок]
    links=( ${2} )

    echo path = ${path}
    echo links = ${links[@]}
    # --------------------------------------------------------------------
}
# ************************************************************************
# function tests

# script tests [тесты скрипта]
tests(){
    # --------------------------------------------------------------------
    # tests [тесты]
    echo '###################tests###################'
    echo '----------settings_get----------'
    echo path_src = ${settings_arr[path_src]}
    echo file_links = ${settings_arr[file_links]}
    echo hist_src = ${settings_arr[hist_src]}
    echo '----------file_links----------'
    echo file_links = ${file_links}
    echo '----------links_arr----------'
    echo ${links_arr[0]}
    echo ${links_arr[1]}
    echo ${links_arr[2]}
    echo '###########################################'
    # --------------------------------------------------------------------
}
# ************************************************************************
# program logic [логика программы]

# checking the necessary installed utilities
# [проверка необходимых установленных утилит]
# check_core_utils git tar which mer # for test [для тестов]
check_core_utils ${utils[@]}

# get settings [получить настройки]
settings_get ${file_settings}

# checking the existence of a directory [проверка существования директории]
check_path ${settings_arr[path_src]}

# get sources from github [получить исходники с github]
src_get ${settings_arr[path_src]} ${links_arr[@]}

# script tests [тесты скрипта]
tests
# ************************************************************************