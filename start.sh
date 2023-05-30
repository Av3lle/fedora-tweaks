#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Скрипт не должен быть запущен от имени пользователя root!"
    exit 1
fi

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
cd "${CURRENT_DIR}" || exit

python3 fedora.py
