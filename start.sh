#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Скрипт не должен быть запущен от имени пользователя root!"
    exit 1
fi


dirr="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
echo "dir = '$dirr/fedora.sh'" > "$dirr"/current_dir.py
cd "${dirr}" || exit


python3 fedora.py
