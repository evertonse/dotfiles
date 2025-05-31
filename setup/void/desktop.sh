sudo xbps-install -Syu xorg xfce4 pulseaudio

sudo xbps-install -Syu elogind dbus dbus-elogind polkit-elogind
sudo ln -sf /etc/sv/elogind /var/service/
sudo ln -sf /etc/sv/dbus    /var/service/
sudo ln -sf /etc/sv/polkitd /var/service/
