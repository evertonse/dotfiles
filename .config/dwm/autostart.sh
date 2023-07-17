#!/bin/sh
xset r rate 186 22
xset s off
xset s off -dpms
xset s off dpms
xmodmap -e "clear lock"
#xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" # uncoment this to make esc act as capslock
xmodmap -e "keycode 66 = Escape NoSymbol Escape"

xrandr --dpi 96		# Set DPI. User may want to use a larger number for larger screens.
#xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/X11/xresources & xrdbpid=$!	# Uncomment to use Xresources colors/settings on startup

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
pkill picom &
xwallpaper --zoom ~/Pictures/681587.png &
exec dwmblocks &
#exec slstatus & # if you use slstatus instead of signal sending Giga Chad dwmblocks 

