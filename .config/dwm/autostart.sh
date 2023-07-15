#!/bin/sh
xset r rate 199 20
xset s off
xset s off -dpms
picom --config ~/.config/picom/picon.conf & 
xwallpaper --zoom ~/Pictures/681587.png &
exec dwmblocks &
#exec slstatus &
