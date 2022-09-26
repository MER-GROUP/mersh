#!/bin/bash

# srcget
# Script for downloading and updating sources from github
# [Скрипт для скачивания и обновления исходников с github]

# read settings
# [считать настройки]
for line in $( grep -v '^#' settings.sh ); do
    echo $line
done