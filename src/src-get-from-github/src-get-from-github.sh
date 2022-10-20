#!/bin/bash
# ************************************************************************
# src-get-from-github

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
utils=( date find git gzip ls mkdir rm tar which )
# ************************************************************************
# function settings_get

# get settings [получить настройки]
settings_get(){ # args: file_path
    # --------------------------------------------------------------------
    # if we are in the mesh folder, then go to mersh/src/src-get-from-github/
    # [если находимся в папке mersh, то переходим в mersh/src/src-get-from-github/]
    # pwd # test
    local current_dir=`pwd`
    # echo "${current_dir##*/}" # test
    local bool="False"
    if [[ `pwd` =~ "mersh"$ ]]; then
        cd ./src/src-get-from-github/
        bool="True"
        # pwd # test
        # cd ../../ # test
        # pwd # test
    fi
    # ----------------------------------
    # the path of the settings file [путь файла с настройками]
    local file_path=${1}
    # get settings [получить настройки]
    for line in $( grep -v '^#' $file_path ); do
        # echo $line
        local arr
        IFS='=' read -a arr <<< ${line}
        settings_arr[${arr[0]}]=${arr[1]}
    done
    # ----------------------------------
    # # show settings v1 [показать настройки]
    # echo ${settings_arr[@]}

    # # show settings v2 [показать настройки]
    # for line in ${settings_arr[@]}; do
    #     echo ${line}
    # done
    # ----------------------------------
    # return to the original directory if there was a transition to another directory
    # [возврат в первоначальную директорию, если был переход в другую директорию]
    if [[ 'True' == ${bool} ]]; then
        cd ${current_dir}
        bool="False"
        # echo "BOOL"
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# function check_path

# checking the existence of a directory [проверка существования директории]
check_path(){ # args: path
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	local path=${1}

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
            local ind
            let "ind = ${#path[0]} - 1"
            # echo "file = ${path[@]:0:${ind}}"
            local file=${path[@]:0:${ind}}
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
	local path=${1}
    # link matrix [матрица ссылок]
    # links=(  ${*} ) 
    local links=(  $( arr=( ${*} ); echo ${arr[@]:1:${#arr[@]}} ) ) 
    # echo path = ${path}
    # echo links = ${links[@]}

    cd ${path}
    # pwd

    # Cloning sources
    # [Клонирование исходников]
    for link in ${links[@]}; do
        echo ""
        echo "Starting cloning ${link}"
        git clone ${link}
        echo "End cloning ${link}"
    done

    cd ..
    # pwd
    # --------------------------------------------------------------------
}
# ************************************************************************
# function src_to_tar_gz

# archive the sources [заархивировать исходники]
src_to_tar_gz(){ # args: path
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	local path=${1}

    cd ${path}
    # pwd

    # getting folders in a directory [получение папок в директории]
    local dirs=( $( ls -p | grep "/$" ) )
    # echo ${dirs[@]}

    # archiving of sources [архивирование исходников]
    for dir in ${dirs[@]}; do
        echo ""
        echo "Starting archiving ${dir}"

        local date_name=$( date +"%Y.%m.%d_%H-%M-%S" )
        # echo ${date_name}

        local ind
        let "ind = ${#dir[0]} - 1"
        local arhive_name=${dir[@]:0:${ind}}
        # echo ${arhive_name}

        local base_name="${arhive_name}_${date_name}.tar.gz"

        # pack the listed files and/or folders into arhive.tar.gz (with gzip compression)
        # tar -zcvf arhive.tar.gz file1 file2 ... fileN
        # [запаковать перечисленные файлы и/или папки в архив.tar.gz (со сжатием при помощи gzip)]
        # [tar -zcvf архив.tar.gz файл1 файл2 ... файлN]
        tar -zcvf ${base_name} ${dir}

        echo "End archiving ${dir}"
    done

    cd ..
    # pwd
    # --------------------------------------------------------------------
}
# ************************************************************************
# function delete_src_folders

# delete source directories [удалить директории с исходниками]
delete_src_folders(){ # args: path
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	local path=${1}

    cd ${path}
    # pwd

    # getting folders in a directory [получение папок в директории]
    local dirs=( $( ls -p | grep "/$" ) )
    # echo ${dirs[@]}

    # delete source directories [удалить директории с исходниками]
    for dir in ${dirs[@]}; do
        echo ""
        echo "Starting delete source directories ${dir}"

        local ind
        let "ind = ${#dir[0]} - 1"
        local dir_src=${dir[@]:0:${ind}}
        # echo ${dir_src}
        rm -rf ${dir_src} &> /dev/null

        echo "End delete source directories ${dir}"
    done

    cd ..
    # pwd
    # --------------------------------------------------------------------
}
# ************************************************************************
# function delete more history

# delete source archives longer than the specified storage history
# [удалить архивы исходников больше заданной истории хранения]
delete_arhive_src_more_history(){ # args: path, hist
    # --------------------------------------------------------------------
    # data storage directory [директория хранения данных]
	local path=${1}

    cd ${path}
    # pwd
    # ----------------------------------
    # getting folders in a directory [получение файлов в директории]
    local files_arr=( $( ls -p | grep -v "/$" ) )
    # echo ${files_arr[@]}
    local i=0
    # let i++
    # echo "i = ${i}"
    local files_base_arr
    for file in ${files_arr[@]}; do
        # echo ${file}
        # echo ${i}
        local file_temp=$( echo ${file%_*}% )
        files_base_arr[${i}]=$( echo ${file_temp%_*} )
        # echo ${files_base_arr[${i}]}
        let i++
    done
    # ----------------------------------
    # apply a set on files
    # [применить множество на файлах]
    # ----------------
    # set_in_math=`pwd`
    # # pwd
    # cd ../../../
    # # pwd
    # source set-in-math.sh
    # cd ${set_in_math}
    # # pwd
    # ----------------
    files_base_arr=( $( set-in-math ${files_base_arr[@]} ) ) 
    # echo "${files_base_arr[@]}"
    # ----------------------------------
    # delete archived sources [удалить архивированные исходниками]
    for arhive_src in ${files_base_arr[@]}; do
        all_arhive_src=( $( ls -1cr | grep "^${arhive_src}" ) )
        # echo ${all_arhive_src[@]}

        # the size of the array minus the history is the number of unnecessary sources
        # [размер массива минус история - это количество лишних исходников]
        local ost
        let "ost = ${#all_arhive_src[@]} - ${settings_arr[hist_src]}"
        # echo ${ost}

        # if the remainder to delete is greater than 0, then we delete unnecessary sources
        # [если остаток для удаления больше 0, то удаляем лишние исходники]
        if [[ 0 -lt ${ost} ]]; then
            # a cycle for deleting sources
            # [цикл для удаления исходников]
            for (( i=0; i < ${ost}; i++ )); do
                echo ""
                echo "Starting delete arhive source ${all_arhive_src[i]}"
                rm -rf ${all_arhive_src[i]} &> /dev/null
                echo "End delete source directories ${all_arhive_src[i]}"
            done
        fi
    done
    # ----------------------------------
    cd ..
    # pwd
    # --------------------------------------------------------------------
}
# ************************************************************************
# function tests

# script tests [тесты скрипта]
tests(){ # NO args
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
# function src-get-from-github

# function for downloading and updating sources from github
# [Функция для скачивания и обновления исходников с github]
src-get-from-github(){ # NO args
    # --------------------------------------------------------------------
    # program logic [логика программы]
    # --------------------------------------------------------------------
    # checking the necessary installed utilities
    # [проверка необходимых установленных утилит]

    # path_src_get_from_github=`pwd`
    # echo ${path_src_get_from_github} # for test [для тестов]


    # if [[ 0 -ne $( type check-install-utils &> /dev/null; echo ${?} ) ]]; then

    #     cd ../../
    #     pwd # for test [для тестов]
    #     source check-install-utils.sh
    #     pwd # for test [для тестов]
    #     cd ${path_src_get_from_github}
    #     pwd # for test [для тестов]

    # fi





    # [для запуска через bash имя_скрипта.sh]
    # cd ../../
    # pwd # for test [для тестов]
    # source check-install-utils.sh
    # pwd # for test [для тестов]
    # cd ${path_src_get_from_github}
    # pwd # for test [для тестов]

    # check=$( check-install-utils "max" "git" "tar" "which" "mer" ) # for test [для тестов]
    check=$( check-install-utils "${utils[@]}" )
    # echo ${check} # for test [для тестов]
    echo -e "${check}"
    # --------------------------------------------------------------------
    # if everything is installed, then continue the program
    # [если все установлено, то продолжить работу программы]
    if [[ 'all utils are installed' == ${check} ]]; then
        # get settings [получить настройки]
        settings_get ${file_settings}

        # checking the existence of a directory [проверка существования директории]
        check_path ${settings_arr[path_src]}

        # get sources from github [получить исходники с github]
        src_get ${settings_arr[path_src]} ${links_arr[@]}

        # archive the sources [заархивировать исходники]
        src_to_tar_gz ${settings_arr[path_src]}

        # delete source directories [удалить директории с исходниками]
        delete_src_folders ${settings_arr[path_src]}

        # delete source archives longer than the specified storage history
        # [удалить архивы исходников больше заданной истории хранения]
        delete_arhive_src_more_history ${settings_arr[path_src]} ${settings_arr[hist_src]}

        # script tests [тесты скрипта]
        # tests
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# init funcs

# function access outside the script
# [доступ функции вне скрипта]
declare -x -f src-get-from-github
# ************************************************************************
# tests

# src-get-from-github # test
# ************************************************************************