#!/bin/bash
read -p "Enter a number: " NUMBER
while [ "$NUMBER" -ge 0 ]; do echo "$NUMBER"; NUMBER=$((NUMBER - 1)); done
echo "Done!"
