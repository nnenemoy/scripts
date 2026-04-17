#!/bin/bash

find . -type f -name "wp-config.php" | while read file; do
    sed -i 's!\r$!!' "$file"
    temp_file=$file.tmp
    > "$temp_file"
    while IFS= read -r line; do
        if [[ -z "$line" ]];
        then
            echo "$RANDOM" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    mv "$temp_file" "$file"
    echo "Готово!"
done
