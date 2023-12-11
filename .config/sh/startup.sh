mkdir /mnt/ntfs1
echo "22041298" | sudo -S mount -t ntfs /dev/nvme0n1p3 /mnt/ntfs1

pkill pipewire &
systemctl disable --global pipewire
systemctl disable --global pipewire-pulse
systemctl disable --global pipewire.socket
systemctl disable --global pipewire-pulse.socket

systemctl enable  --global pulseaudio

systemctl --global disable pipewire.socket
######## Only one that Works ###########
systemctl --user stop pipewire.socket ##
########################################
systemctl disable --user  pipewire
systemctl disable --user  pipewire-pulse
systemctl enable  --user  pulseaudio
pulseaudio &
