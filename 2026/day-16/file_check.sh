#!/bin/bash
read -p "Enter filename: " FILE

if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
fi
