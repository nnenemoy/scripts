#!/bin/bash

SCRIPT_NAME=$(basename "$0")
CONFIG=$(grep -rl -E "define\s*\(\s*['\"]DB_PASSWORD['\"]" | grep -v "$SCRIPT_NAME")
NEW_PASSWORD=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

for i in $CONFIG; do
    LINE=$(grep -rnh -E "define\s*\(\s*['\"]DB_PASSWORD['\"]" "$i" | cut -d: -f1)
    sed -i "${LINE}s/.*/define( 'DB_PASSWORD', '$NEW_PASSWORD' );/" "$i"
    echo "Пароль изменен на $NEW_PASSWORD"
done