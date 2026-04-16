#!/bin/bash

L_FILE="errors.log"

MAX_FS=1000000

rotatelog ()
{
    for i in {4..1}; do
        mv "$L_FILE."{$i,$((i+1))}
    done
    mv $L_FILE $L_FILE".1"
    touch $L_FILE
}

if [ -e $L_FILE ]
then 
    REAL_FS=$(wc -c $L_FILE | awk '{print $1}')
    echo "Размер файла $L_FILE: "$(($REAL_FS)) "байт"
    if [ $REAL_FS -ge $MAX_FS ]
    then
        rotatelog
        echo "Ротация логов прошла успешно - балдеж =)"
    else
        echo "Ротация логов не требуется"
    fi
else
    echo "Файла $L_FILE не существует"
fi