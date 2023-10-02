#!/bin/sh

autostart="mpd dunst unclutter blueman-applet" # pipewire instead of pulseaudio ? also, picom add picom
start() {
  pidof -sx "$1" > /dev/null 2> /dev/null || "$@" &
}

/home/excyber/.config/sh/vars.sh &

for program in $autostart; do
	start "$program"
done >/dev/null 2>&1

# start xsettingsd
# start sxhkd
# Ensure that xrdb has finished running before moving on to start the WM/DE.
# [ -n "$xrdbpid" ] && wait "$xrdbpid"

#start picom --config ~/.config/picom/picon.conf & # enable it if your pc is a little faster

pkill picom &
pkill pipewire &
xwallpaper --zoom ~/Pictures/681587.png &
xkbcomp $HOME/.config/X11/xkb/keymap/excyber-keymap $DISPLAY
pulseaudio &
google-chrome-stable &
exec dwmblocks &
# mode-sleep &
#exec slstatus & # if you use slstatus instead of signal sending Giga Chad dwmblocks 

