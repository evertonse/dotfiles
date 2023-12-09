#!/bin/bash
sudo apt install nala -y

installpkg() {
  echo "installing package $1"
	sudo nala install -y "$2"; 
}

echo " This script assumes every git clone will be placed under $HOME/code folder"
echo " if this folder already has a certain repo, no action will be taken"
# @basic
for x in make cmake python3 curl wget ca-certificates git ntp zsh unzip npm ripgrep fd fzf libxft go usbutils ddcutil; do
	installpkg "$x"
done

# @firmware
read -p "Do you want install firmware and update it with fwupd? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  installpkg fwupd
  sudo fwupdmgr get-devices
  sudo fwupdmgr refresh --force
  sudo fwupdmgr get-updates -y
  sudo fwupdmgr update -y
else
    echo "No action needed was done about firmware ."
fi

# linux idk you'll need


read -p "Do you want install linux-header, base-devel and linux firmware stuff ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
	for x in base-devel  linux-zen linux linux-headers linux-api-headers linux-firmware linux-docs; do
		installpkg "$x"
	done
else
  echo "No action needed was done about linux stuff."
fi

# @radare

read -p "Do you want install radare ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  git clone https://github.com/radare/radare2 $HOME/code/radare 
  cd $HOME/code/radare 
  sh sys/install.sh
fi

# @neovim
read -p "Do you want install neovim? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  dir="$HOME/code/neovim"
  [ ! -d $dir ] && git clone https://github.com/neovim/neovim.git $dir
  cd $HOME/code/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
fi

# @x11 stuff

read -p "Do you want install X11? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  sudo nala install -y xorg xorg-server xorg-xinit xorg-xsetroot xorg-xbacklight yabar  
  sudo nala install -y xcb-proto xcb-util xcb-util-wm xcb-util-cursor xcb-util-keysyms
  sudo nala install -y libxinerama autorandr
fi

read -n1 -rep "Do you want install Wayland stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then

    sudo nala install -y hyprland kitty waybar yambar \
    swaybg swaylock-effects wofi wlogout mako thunar \
    ttf-jetbrains-mono-nerd noto-fonts-emoji \
    polkit-gnome python-requests starship \
    swappy grim slurp pamixer brightnessctl gvfs \
    bluez bluez-utils lxappearance xfce4-settings \
    dracula-gtk-theme dracula-icons-git xdg-desktop-portal-hyprland wdisplays

    sudo nala install -y swaylock waybar
    sudo nala install -y hyprland-bin polkit-gnome ffmpeg neovim viewnior       \
    rofi pavucontrol thunar starship wl-clipboard wf-recorder     \
    swaybg grimblast-git ffmpegthumbnailer tumbler playerctl      \
    noise-suppression-for-voice thunar-archive-plugin kitty       \
    waybar-hyprland wlogout swaylock-effects sddm-git pamixer     \
    nwg-look-bin nordic-theme papirus-icon-theme dunst otf-sora   \
    ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font    \
    ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa  \
    ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd  \
    adobe-source-code-pro-fonts

    xdg-user-dirs-update
    echo " All necessary packages installed successfully."
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py

    ### Add Fonts for Waybar ###
    mkdir -p $HOME/Downloads/nerdfonts/
    cd $HOME/Downloads/
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
    unzip '*.zip' -d $HOME/Downloads/nerdfonts/
    rm -rf *.zip
    sudo cp -R $HOME/Downloads/nerdfonts/ /usr/share/fonts/

    fc-cache -rv  

    ### Enable SDDM Autologin ###
    read -n1 -rep 'Would you like to enable SDDM autologin? (y,n)' SDDM
    if [[ $SDDM == "Y" || $SDDM == "y" ]]; then
      LOC="/etc/sddm.conf"
      echo -e "The following has been added to $LOC.\n"
      echo -e "[Autologin]\nUser = $(whoami)\nSession=hyprland" | sudo tee -a $LOC
      echo -e "\n"
      echo -e "Enabling SDDM service...\n"
      sudo systemctl enable sddm
      sleep 3
    fi


    
    sudo nala install -y bluez bluez-utils blueman
    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    sudo nala install -y xdg-desktop-portal-gnome xdg-desktop-portal-gtk

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


read -p "Do you want install suckless and rocks stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  dir="$HOME/code/rocks"
  [ ! -d $dir ] && git clone https://github.com/evertonse/rocks.git $dir
   cd $dir && ./install
fi

read -p "Do you want install drivers not installed already ? (xf86-video, rtl87)  [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  sudo nala install -y xf86-video
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
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  sudo nala install -y  --noconfirm libnotify
  dir="$HOME/code/dunst"
  [ ! -d $dir ] && git clone https://github.com/dunst-project/dunst.git $dir 
  cd $dir && make && sudo make install
fi


# @user pkg
read -p "Do you want install the user stuff (tmux, lf , zathura, htop)? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  timedatectl set-timezone America/Maceio
  sudo nala install -y zathura glow lf mpv zsh tmux mupdf
  #sudo nala install -y  neovim --noconfirm
  # python-pywal -> wal
  sudo nala install -y xwallpaper picom python-pywal ueberzug 
  sudo nala install -y fd ripgrep flameshot grim sysstat wget  netctl networkmanager vivid Imlib2 nsxiv feh gummy
  # just htop with vim motions
	sudo nala install -y htim btop

  # @important(tdrop) https://www.youtube.com/watch?v=TbbsjyoK0J4 https://github.com/noctuid/tdrop
  sudo nala install -y  tdrop
  # @important(sxhkd) https://github.com/baskerville/sxhkd
  sudo nala install -y  sxhkd 
  sudo nala install -y  ytfzf 
  sudo nala install -y  yt-dlp
  sudo nala install -y  yt-watch 
  sudo nala install -y  cwitch
  sudo nala install -y  rofi 
  sudo nala install -y y --needed rust gtk4 base-devel
  cargo install ripdrag
  sudo nala install -y  obs
  sudo nala install -y  brightness-controller
  sudo nala install -y  picom-jonaburg-git # rounded corners with https://github.com/jonaburg/picom
  # @important(simple key daemon) https://github.com/baskerville/sxhkd
  git clone https://github.com/vinceliuice/Lavanda-gtk-theme $HOME/code/git/gtk-lavanda/ && cd  $HOME/code/git/gtk-lavanda/ && ./install.sh -d $HOME/.config/themes/lavanda
  sudo nala install -y  --noconfirm gnome-themes-extra adwaita-qt5 adwaita-qt6 
fi

read -p "Do you want install the pulseaudio-apps (not pulseaudio itself) and tui-related to audio stuff? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  # sudo nala install -y  --noconfirm  pipewire pipewire-alsa pipewire-jack pipewire-pulse libpulse
  # look https://github.com/GeorgeFilipkin/pulsemixer
  #curl https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer > pulsemixer && chmod +x ./pulsemixer
  # look https://github.com/fulhax/ncpamixer
  sudo nala install -y  ncpamixer
  sudo nala install -y  pulsemixer 
  sudo nala install -y  ncmpcpp 
fi

read -p "Do you want install the 1:pipewire or 2:pulseaudio [1/2]: " answer
if [ "$answer" = "1" ] || [ "$answer" = "y" ]; then
  echo "wireplumber libwireplumber might be prefered than pipewire-media-session (currently being install), on older hardware wireplumber seems to consumed 100% of cpu and memory :S"
  echo "if you get stuck with wireplumber try pacman -Rdd wireplumber && pacman -S pipewire-media-session"
  for x in pipewire pipewire-roc pipewire-alsa pipewire-jack pipewire-pulse libpipewire pipewire-media-session; do
    installpkg "$x"
  done
elif [ "$answer" = "2" ] || [ "$answer" = "bangkok" ]; then 
  for x in pulseaudio pulseaudio-rtp pulseaudio-lirc pulseaudio-alsa pulseaudio-jack pulseaudio-bluetooth pulseaudio-zeroconf pulse-autoconf pasystray-git libpulse; do
    installpkg "$x"
  done
  fi

  read -p "Do you want install nerdfonts? [y/n]: " answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    sudo nala install -y  --noconfirm gnu-free-fonts noto-fonts ttf-jetbrains-mono
    sudo nala install -y  nerd-fonts-complete-mono-glyphs  # these one is very slow
    sudo nala install -y  ttf-jetbrains-mono-nerd
    sudo nala install -y  noto-fonts-emoji
  fi

  read -p "Do you want install tui (bluetuith, nmtui, torque, stig)? [y/n]: " answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    sudo nala install -y  network-manager-applet
    go install github.com/darkhz/bluetuith@latest
    sudo nala install -y  bluez bluez-utils
    sudo nala install -y  bluetuith
    installpkg transmission-cli
    sudo nala install -y   transmission-gtk transmission-cli stig tremc
  fi

  read -p "Do you want install developer stuff (pocl, gitui, rusticl, go, clang, etc... )? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  sudo nala install -y yu gdb rlwrap go clang pocl opencl-rusticl-mesa npm python-pipx gitui prettier deno qutebrowser libvirt
  git clone https://github.com/nakst/gf.git ~/code/gf/ && cd ~/code/gf && ./build.sh && sudo ln -sf ~/code/gf/gf2 /usr/bin/gf
  git clone https://github.com/longld/peda.git ~/code/peda
  echo "source ~/code/peda/peda.py" >> ~/.gdbinit
  echo "DONE! debug your program with gdb and enjoy"

fi

chsh -s /usr/bin/zsh

