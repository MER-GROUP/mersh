#!/bin/bash
# ************************************************************************
# importing scripts into bash/zsh
# [импортирование скриптов в bash/zsh]
# ************************************************************************
# function import

# importing scripts into bash/zsh
# [импортирование скриптов в bash/zsh]
import(){ # NO args
    # --------------------------------------------------------------------
    # getting folders in a directory [получение файлов в директории]
    local files_arr=( $( ls -p | grep -v "/$" ) )
    # echo "${files_arr[@]}" # test
    # ----------------------------------
    # importing scripts into bash/zsh
    # [импортирование скриптов в bash/zsh]
    # source ./check-install-utils.sh
    # source ./mersh.sh
    # source ./set-in-math.sh
    # source ./src-get-from-github.sh
    # ...
    # source ./sum-in-math.sh
    for lib in ${files_arr[@]}; do
        if [[ 'import.sh' == ${lib} ]]; then
            continue
        elif [[ 'install-in-bash.sh' == ${lib} ]]; then
            continue
        elif [[ 'install-in-zsh.sh' == ${lib} ]]; then
            continue
        elif [[ 'uninstall-mersh.sh' == ${lib} ]]; then
            continue
        elif [[ 'import.sh' == ${lib} ]]; then
            continue
        else
            local func=$( echo ${lib%.*} )
            # echo "${func}" # test
            if [[ 0 -ne $( type ${func} &> /dev/null; echo ${?} ) ]]; then
                source ${lib}
            fi
        fi
    done
    # --------------------------------------------------------------------
}
# ************************************************************************
# importing scripts into bash/zsh
# [импортирование скриптов в bash/zsh]
import
# ************************************************************************
# tests

# use in other scripts
# [использование в других скриптах]
# source ./import.sh # test
# ************************************************************************