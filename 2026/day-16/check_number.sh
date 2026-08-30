#!/bin/bash
read -p "Enter a number: " NUMBER

if [ "$NUMBER" -gt 0 ]; then
    echo "Positive"
elif [ "$NUMBER" -lt 0 ]; then
    echo "Negative"
else
    echo "Zero"
fi
