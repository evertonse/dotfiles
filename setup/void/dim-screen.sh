temperature=4500K
dim=0.2
backlight=9
gammastep -x
gammastep -l3:3 -L $temperature -b $dim:$dim &> /dev/null
light -S $backlight
