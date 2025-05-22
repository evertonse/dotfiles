#!/bin/dash
for i in {0..255}; do
    # Print the color number and the color itself
    printf "\e[38;5;%dm%3d\e[0m " "$i" "$i"
    
    # Print a new line after every 16 colors for better readability
    if (( (i + 1) % 16 == 0 )); then
        echo
    fi
done

