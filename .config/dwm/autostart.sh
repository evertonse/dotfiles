#!/bin/sh
xset r rate 186 20
xset s off
xset s off -dpms
xset s off dpms
xmodmap -e "clear lock"
xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
#picom --config ~/.config/picom/picon.conf & # enable it if your pc is a little faster
xwallpaper --zoom ~/Pictures/681587.png &
exec dwmblocks &
#exec slstatus &
