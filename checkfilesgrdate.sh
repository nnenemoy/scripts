#!/bin/bash

DATE=""
USER_GR=""

show_help() {
echo -e "Команда работает с параметрами --date (YYYY-MM-DD) и --group (название группы пользователя)"
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--date) DATE="$2"; shift 2 ;;
        -g|--group) USER_GR="$2"; shift 2 ;;
        -h|--help) show_help; exit 0 ;;
        *)
            echo "ТЫ че ввел? Прочитай гайд прежде чем тыкать =/"
            show_help
            exit 1
            ;;
    esac
done

if [[ -n "$DATE" ]]; then
    echo "Файлы измененные за дату $DATE:"
    find . -type f -newermt "$DATE" ! -newermt "$DATE + 1 day" 2>/dev/null | while read file; do
        ls "$file"
    done
fi

if [[ -n "$USER_GR" ]]; then
    echo "Файлы группы $USER_GR:"
    find . -type f -group "$USER_GR" | while read file; do
        ls "$file"
    done
fi

