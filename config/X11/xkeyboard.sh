#!/bin/sh
# Remap keys
start setxkbmap -option caps:escape
start xmodmap -e "keycode 34 = BackSpace"

xset r rate 235 32 &
# start xset s off -dpms

start sxhkd
# Load custom keymap
# start xkbcomp "$HOME/.config/X11/xkb/keymap/excyber-keymap" "$DISPLAY"

