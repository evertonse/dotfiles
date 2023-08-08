#!/bin/bash
pacman -Syyuu
autoyes="$1"

installpkg() {
  echo "installing package $1"
	#pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
	sudo pacman --noconfirm --needed -S "$1" || yay --noconfirm --needed -S "$1"
}

echo " This script assumes every git clone will be placed under $HOME/code folder"
echo " if this folder already has a certain repo, no action will be taken"
# @basic
for x in networkmanager make cmake curl wget ca-certificates base-devel git ntp zsh unzip npm ripgrep fd fzf libxft go usbutils ddcutil; do
	installpkg "$x"
done

# @firmware
read -p "Do you want install firmware and update it with fwupd? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -Syu --noconfirm fwupd
  sudo fwupdmgr get-devices
  sudo fwupdmgr refresh --force
  sudo fwupdmgr get-updates -y
  sudo fwupdmgr update -y
else
    echo "No action needed was done about firmware ."
fi

# linux idk you'll need

read -p "Do you want install linux-header, base-devel and linux firmware stuff ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -S base-devel  linux-zen linux linux-headers linux-api-headers linux-firmware linux-docs --noconfirm
else
  echo "No action needed was done about linux stuff."
fi

# @radare

read -p "Do you want install radare ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  git clone https://github.com/radare/radare2 $HOME/code/radare 
  cd $HOME/code/radare 
  sh sys/install.sh
fi

# @yay
read -p "Do you want install yay? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -S --needed git base-devel
  dir="$HOME/code/yay"
  [ ! -d $dir ] && git clone https://aur.archlinux.org/yay.git $dir
  cd $dir && makepkg -si
fi

# @neovim
read -p "Do you want install neovim? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  dir="$HOME/code/neovim"
  [ ! -d $dir ] && git clone https://github.com/neovim/neovim.git $dir
  cd $HOME/code/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
fi

# @x11 stuff

read -p "Do you want install X11? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -S --noconfirm xorg xorg-server xorg-xinit xorg-xsetroot xorg-xbacklight yabar  
  sudo pacman -S --noconfirm xcb-proto xcb-util xcb-util-wm xcb-util-cursor xcb-util-keysyms
  sudo pacman -S --noconfirm libxinerama autorandr
fi

read -n1 -rep "Do you want install Wayland stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
    yay -S --noconfirm hyprland kitty waybar yambar \
    swaybg swaylock-effects wofi wlogout mako thunar \
    ttf-jetbrains-mono-nerd noto-fonts-emoji \
    polkit-gnome python-requests starship \
    swappy grim slurp pamixer brightnessctl gvfs \
    bluez bluez-utils lxappearance xfce4-settings \
    dracula-gtk-theme dracula-icons-git xdg-desktop-portal-hyprland

    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk

fi

### Disable wifi powersave mode ###
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Install software for Asus ROG laptops ###
read -n1 -rep 'Would you like to install Asus ROG software support? (y,n)'answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then 
    echo -e "Adding Keys... \n"
    sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

    LOC="/etc/pacman.conf"
    echo -e "Updating $LOC with g14 repo.\n"
    echo -e "\n[g14]\nServer = https://arch.asus-linux.org" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Update the system...\n"
    sudo pacman -Suy

    echo -e "Installing ROG pacakges...\n"
    sudo pacman -S --noconfirm asusctl supergfxctl rog-control-center
    echo -e "Activating ROG services...\n"
    sudo systemctl enable --now power-profiles-daemon.service
    sleep 2
    sudo systemctl enable --now supergfxd
    sleep 2
fi

read -p "Do you want install suckless and rocks stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  dir="$HOME/code/rocks"
  [ ! -d $dir ] && git clone https://github.com/evertonse/rocks.git $dir
   cd $dir && ./install
fi

read -p "Do you want install drivers not installed already ? (xf86-video, rtl87)  [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  yay --noconfirm xf86-video
  lsusb
  lspci -k
  read -p "Take a look at lspci and lsusb to see if you need any of rtl87*  (you might need broadcom)  [y/n]: " answer
  [ "$answer" = "y" ] ] && yay --noconfirm rtl87
  sudo iw dev wlan0 set power_save off
  echo "might wanna check journalctl -xb"
  echo "if Problems wifi diconnecting, disable pci-express management in the bios or iw dev wlan0 set power_save off"
  # @archwiki Network_configuration/Wireless
fi

read -p "Do you want install the notification daemon 'dunst' stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -S --noconfirm libnotify
  dir="$HOME/code/dunst"
  [ ! -d $dir ] && git clone https://github.com/dunst-project/dunst.git $dir 
  cd $dir && make && sudo make install
fi


# @user pkg
read -p "Do you want install the user stuff (tmux, lf , zathura, htop)? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  timedatectl set-timezone America/Maceio
  sudo pacman -S --noconfirm zathura glow lf mpv zsh tmux mupdf
  #sudo pacman -S neovim --noconfirm
  # python-pywal -> wal
  sudo pacman -S --noconfirm xwallpaper picom python-pywal ueberzug 
  sudo pacman -S --noconfirm fd ripgrep flameshot grim sysstat wget  netctl networkmanager 
  yay --noconfirm -S vivid 
  yay --noconfirm -S Imlib2
  yay --noconfirm -S nsxiv
  yay --noconfirm -S feh
  yay --noconfirm -S gummy
  # just htop with vim motions

  yay --noconfirm -S htim  || yay --noconfirm -S htop-vim 

  # @important(tdrop) https://www.youtube.com/watch?v=TbbsjyoK0J4 https://github.com/noctuid/tdrop
  yay --noconfirm -S tdrop
  # @important(sxhkd) https://github.com/baskerville/sxhkd
  yay --noconfirm -S sxhkd 
  yay --noconfirm -S ytfzf 
  yay --noconfirm -S yt-dlp
  yay --noconfirm -S yt-watch 
  yay --noconfirm -S cwitch
  yay --noconfirm -S rofi 
  sudo pacman -Sy --needed rust gtk4 base-devel
  cargo install ripdrag
  yay --noconfirm -S obs
  yay --noconfirm -S brightness-controller
  yay --noconfirm -S picom-jonaburg-git # rounded corners with https://github.com/jonaburg/picom
  # @important(simple key daemon) https://github.com/baskerville/sxhkd
  git clone https://github.com/vinceliuice/Lavanda-gtk-theme $HOME/code/git/gtk-lavanda/ && cd  $HOME/code/git/gtk-lavanda/ && ./install.sh -d $HOME/.config/themes/lavanda
  sudo pacman -S --noconfirm gnome-themes-extra adwaita-qt5 adwaita-qt6 
fi

read -p "Do you want install the pulseaudio-apps (not pulseaudio itself) and tui-related to audio stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  # sudo pacman -S --noconfirm  pipewire pipewire-alsa pipewire-jack pipewire-pulse libpulse
  # look https://github.com/GeorgeFilipkin/pulsemixer
  #curl https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer > pulsemixer && chmod +x ./pulsemixer
  # look https://github.com/fulhax/ncpamixer
  yay --noconfirm -S ncpamixer
  yay --noconfirm -S pulsemixer 
  yay --noconfirm -S ncmpcpp 
fi

read -p "Do you want install the 1:pipewire or 2:pulseaudio [1/2]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  echo "wireplumber libwireplumber might be prefered than pipewire-media-session (currently being install), on older hardware wireplumber seems to consumed 100% of cpu and memory :S"
  echo "if you get stuck with wireplumber try pacman -Rdd wireplumber && pacman -S pipewire-media-session"
  for x in pipewire pipewire-roc pipewire-alsa pipewire-jack pipewire-pulse libpipewire pipewire-media-session; do
    installpkg "$x"
  done
elif [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then 
  for x in pulseaudio pulseaudio-rtp pulseaudio-lirc pulseaudio-alsa pulseaudio-jack pulseaudio-bluetooth pulseaudio-zeroconf pulse-autoconf pasystray-git libpulse; do
    installpkg "$x"
  done
fi

read -p "Do you want install nerdfonts? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  sudo pacman -S --noconfirm gnu-free-fonts noto-fonts ttf-jetbrains-mono
  yay --noconfirm -S nerd-fonts-complete-mono-glyphs  # these one is very slow
  yay --noconfirm -S ttf-jetbrains-mono-nerd
  yay --noconfirm -S noto-fonts-emoji
fi

read -p "Do you want install tui (bluetuith, nmtui, torque)? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  go install github.com/darkhz/bluetuith@latest
  yay --noconfirm -S bluez
  yay --noconfirm -S bluez bluez-utils
  yay --noconfirm -S bluetuith
  installpkg transmission-cli
fi

read -p "Do you want install developer stuff (pocl, rusticl, go, clang, etc... )? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "y" ] ]; then
  yay --noconfirm -S go clang pocl rusticl npm pipx
  
fi

chsh -s /usr/bin/zsh

