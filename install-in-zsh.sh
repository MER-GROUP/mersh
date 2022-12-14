#!/bin/bash
# ************************************************************************
# installing scripts in zsh
# [установка скриптов в zsh]
# ************************************************************************
# function install-in-zsh

# installing scripts in zsh
# [установка скриптов в zsh]
install-in-zsh(){ # NO args
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
    # if importing mersh scripts to zsh was
    # [если импорта скриптов mersh в zsh был]
    # if [[ '# mersh scripts' == $( grep "^# mersh scripts" ~/.zshrc | cut -d ' ' -f 1-3 ) ]]; then # or
    if [[ '# mersh scripts' == $( echo $( current_search=`grep "^# mersh scripts" ~/.zshrc`; echo "${current_search%[*}" ) ) ]]; then # or
        echo "zsh -> setting up ок"
    else
        # if there was no import of mersh scripts into zsh
        # [если импорта скриптов mersh в zsh не было]
        # ----------------
        # importing mersh scripts to ~/.zshrc
        # [импорт скриптов mersh в ~/.zshrc]
        echo "" >> ${HOME}/.zshrc
        echo "# mersh scripts [сценарии mersh]" >> ${HOME}/.zshrc
        echo "current_dir=\`pwd\`" >> ${HOME}/.zshrc
        echo "cd /home/red/.mer-group/mersh/" >> ${HOME}/.zshrc
        echo "source import.sh" >> ${HOME}/.zshrc
        echo 'cd "${current_dir}"' >> ${HOME}/.zshrc
        echo "" >> ${HOME}/.zshrc
        echo "zsh -> setting up ок"
        # ----------------
        # restarting zsh
        # [перезапуск zsh]
        source ${HOME}/.zshrc
        # ----------------
    fi
    # --------------------------------------------------------------------
}
# ************************************************************************
# installing scripts in zsh
# [установка скриптов в zsh]
install-in-zsh
# ************************************************************************