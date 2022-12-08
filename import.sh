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
    # importing scripts into bash/zsh
    # [импортирование скриптов в bash/zsh]
    source ./check-install-utils.sh
    source ./mersh.sh
    source ./set-in-math.sh
    source ./src-get-from-github.sh
    source ./sum-in-math.sh
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