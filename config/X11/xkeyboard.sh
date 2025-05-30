#!/bin/sh

start() {
    if command -v "$1" > /dev/null 2>&1; then
        # Check if the program is already running
        if ! pidof -sx "$1" &> /dev/null; then
            "$@" &
            echo "Started: $*" >> ~/xinit.log
        else
            echo "Already running: $*" >> ~/xinit.log
        fi
    else
        echo "Executable not found: $1" >> ~/xinit.log
    fi
}

# Remap keys
start setxkbmap -option caps:escape
start xmodmap -e "keycode 34 = BackSpace"

xset r rate 235 32 &
# start xset s off -dpms

start sxhkd
# Load custom keymap
# start xkbcomp "$HOME/.config/X11/xkb/keymap/excyber-keymap" "$DISPLAY"

