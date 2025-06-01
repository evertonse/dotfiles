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

xmodmap -e "keycode 34 = BackSpace"
xmodmap -e "keycode 49 = BackSpace"
xmodmap -e "keycode 151 = Alt_R"

xset r rate 220 32 &
# start xset s off -dpms

start sxhkd
# Load custom keymap
# start xkbcomp "$HOME/.config/X11/xkb/keymap/excyber-keymap" "$DISPLAY"

