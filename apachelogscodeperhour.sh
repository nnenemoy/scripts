#!/bin/bash

LOG_SOURCE="access.log"

LOL=$(awk '$14!="\"-\"" {split($1,a,":"); print a[2], $5}' "$LOG_SOURCE" | sort | uniq -c)

echo "$LOL"
