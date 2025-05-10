#!/bin/sh

PSSWD="22041298"
mkdir /mnt/ntfs1
echo $PSSWD | sudo -S mount -t ntfs /dev/nvme0n1p3 /mnt/ntfs1

pkill pipewire &
echo $PSSWD | sudo -S systemctl disable --global pipewire
echo $PSSWD | sudo -S systemctl disable --global pipewire-pulse
echo $PSSWD | sudo -S systemctl disable --global pipewire.socket
echo $PSSWD | sudo -S systemctl disable --global pipewire-pulse.socket

echo $PSSWD | sudo -S systemctl stop pipewire.service
echo $PSSWD | sudo -S systemctl disable pipewire.service
echo $PSSWD | sudo -S systemctl mask pipewire.service

echo $PSSWD | sudo -S systemctl enable  --global pulseaudio

echo $PSSWD | sudo -S systemctl --global disable pipewire.socket
######## Only one that Works ###########
echo $PSSWD | sudo -S systemctl --user stop pipewire.socket ##
########################################
echo $PSSWD | sudo -S systemctl disable --user  pipewire
echo $PSSWD | sudo -S systemctl disable --user  pipewire-pulse
echo $PSSWD | sudo -S systemctl enable  --user  pulseaudio
pulseaudio &
