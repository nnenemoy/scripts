#!/bin/bash

while read -r line; do
        PASS=$(echo $line | cut -d';' -f2)
        LOGIN=$(echo $line | cut -d';' -f1)
        useradd $LOGIN
        echo "$LOGIN:$PASS" | chpasswd
        #userdel $LOGIN
done < user_list.txt