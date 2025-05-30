#!/usr/bin/env sh
temperature=6500K
dim=0.9
backlight=50
gammastep -x
gammastep -l3:3 -m randr -O $temperature -b $dim:$dim &> /dev/null
light -S $backlight
