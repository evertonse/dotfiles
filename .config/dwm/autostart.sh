#!/bin/sh

autostart="mpd xcompmgr dunst unclutter remapd " # pipewire instead of pulseaudio ? also, picom add picom
start() {
  pidof -sx "$1" > /dev/null 2> /dev/null || "$@" &
}

/home/excyber/.config/sh/vars.sh &

start blueman-applet
for program in $autostart; do
	start "$program"
done >/dev/null 2>&1

start xsettingsd
start sxhkd
# Ensure that xrdb has finished running before moving on to start the WM/DE.
[ -n "$xrdbpid" ] && wait "$xrdbpid"

#start picom --config ~/.config/picom/picon.conf & # enable it if your pc is a little faster

# xmodmap -e "clear lock" 
pkill picom &
pkill pipewire &
xwallpaper --zoom ~/Pictures/681587.png &
exec dwmblocks &
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
xmodmap -e "keycode 66 = Escape Caps_Lock NoSymbol NoSymbol"
#exec slstatus & # if you use slstatus instead of signal sending Giga Chad dwmblocks 

