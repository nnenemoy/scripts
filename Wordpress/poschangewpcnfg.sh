#!/bin/bash

find . -type f -name "wp-config.php" | while read -r file; do
    if grep -q "define( 'AUTH_KEY', *'' *)" "$file"; then
        sed -i "s!define( 'AUTH_KEY', *'' )!define( 'AUTH_KEY', '$(date +%s | sha256sum | base64 | head -c 64 ; echo)' )!" "$file"
        echo "Готово! AUTH_KEY добавлен в $file"
    else
        echo "В $file уже есть AUTH_KEY"
    fi
done
