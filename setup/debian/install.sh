#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt -y
sudo apt install git vim nala -y

installpkg() {
  echo "installing package $1 $2"
	sudo nala install -y "$1"; 
}


nonfree=(
  "deb http://deb.debian.org/debian/ buster main contrib non-free"
  "deb-src http://deb.debian.org/debian/ buster main contrib non-free"

  "deb http://security.debian.org/debian-security buster/updates main contrib non-free"
  "deb-src http://security.debian.org/debian-security buster/updates main contrib non-free"

  "deb http://deb.debian.org/debian/ buster-updates main contrib non-free"
  "deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free"
  "deb http://deb.debian.org/debian/ bullseye main contrib non-free"
)

read -p "nonfree ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  for x in "${nonfree[@]}"; do
    awk '!seen[$0]++' /etc/apt/sources.list | sudo tee /etc/apt/sources.list
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo "$x"| sudo tee -a /etc/apt/sources.list
  done
fi


read -p "nvidia ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  source ./setup/debian/installs/nvidia.sh
fi



dependencies=(
  libncurses-dev
  pulseaudio
  xdg-user-dirs
  copyq cliphist
  libxcb1-dev libxcb-util0-dev
  xserver-xorg-video-amdgpu
  libtomlplusplus-dev
  xserver-xorg-video-nvidia
  firmware-iwlwifi
	network-manager network-manager-gnome
  pulsemixer
  easyeffects
  meson
  wget
  pipx
  texlive-full
  sox ffmpeg libcairo2 libcairo2-dev
  ninja-build gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev xdg-desktop-portal-wlr libtomlplusplus3
  make cmake python3 curl ca-certificates git ntp zsh unzip npm ripgrep
  fd-find fzf libxft go usbutils ddcutil
  build-essential
  cmake
  cmake-extras
  curl
  gettext
  gir1.2-graphene-1.0
  git
  glslang-tools
  gobject-introspection
  golang
  hwdata
  jq
  libavcodec-dev
  libavformat-dev
  libavutil-dev
  libcairo2-dev
  libdeflate-dev
  libdisplay-info-dev
  libdrm-dev
  libegl1-mesa-dev
  libgbm-dev
  libgdk-pixbuf-2.0-dev
  libgdk-pixbuf2.0-bin
  libgirepository1.0-dev
  libgl1-mesa-dev
  libgraphene-1.0-0
  libgraphene-1.0-dev
  libgtk-3-dev
  libgulkan-0.15-0
  libgulkan-dev
  libinih-dev
  libinput-dev
  libjbig-dev
  libjpeg-dev
  libjpeg62-turbo-dev
  liblerc-dev
  libliftoff-dev
  liblzma-dev
  libnotify-bin
  libpam0g-dev
  libpango1.0-dev
  libpipewire-0.3-dev
  libqt6svg6
  libseat-dev
  libstartup-notification0-dev
  libswresample-dev
  libsystemd-dev
  libtiff-dev
  libtiffxx6
  libudev-dev
  libvkfft-dev
  libvulkan-dev
  libvulkan-volk-dev
  libwayland-dev
  libwebp-dev
  libxcb-composite0-dev
  libxcb-cursor-dev
  libxcb-dri3-dev
  libxcb-ewmh-dev
  libxcb-icccm4-dev
  libxcb-present-dev
  libxcb-render-util0-dev
  libxcb-res0-dev
  libxcb-util-dev
  libxcb-xinerama0-dev
  libxcb-xinput-dev
  libxcb-xkb-dev
  libxkbcommon-dev
  libxkbcommon-x11-dev
  libxkbregistry-dev
  libxml2-dev
  libxxhash-dev
  openssl
  psmisc
  python3-mako
  python3-markdown
  python3-markupsafe
  python3-yaml
  qt6-base-dev
  scdoc
  seatd
  spirv-tools
  vulkan-validationlayers
  vulkan-validationlayers-dev
  wayland-protocols
  xdg-desktop-portal
  xwayland
  wtype
  wev
  flameshot
  bison
)


sudo apt build-dep wlroots
echo " This script assumes every git clone will be placed under $HOME/code folder"
echo " if this folder already has a certain repo, no action will be taken"
# @basic
for x in "${dependencies[@]}"; do
  echo "$x"
	installpkg "$x"
done

sudo ln -sf $(which fdfind) ~/.local/bin/fd

# @firmware
read -p "Hyprland [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  source ./setup/debian/installs/hypr-pkgs.sh
  # version="v0.24.1" # This version works
  VERSION="v0.33.0"
  PATH="~/code/Hyprland-$VERSION"

  git clone --recursive https://github.com/hyprwm/Hyprland -b $VERSION "$PATH"
  cd "$PATH"
  cd subprojects
  git clone https://gitlab.freedesktop.org/emersion/libdisplay-info
  git clone https://github.com/emersion/libliftoff
  cd ..
  meson build
  ninja -C build
  sudo ninja -C build install
else
  echo "No action needed was done about firmware ."
fi

read -p "Do you want install linux-header, base-devel and linux firmware stuff ? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
	for x in build-essential autoconf automake gdb git libffi-dev zlib1g-dev libssl-dev linux-zen linux linux-headers linux-api-headers linux-firmware linux-docs; do
	    installpkg "$x"
	done
else
  echo "No action needed was done about linux stuff."
fi


read -p "Do you want install go lang? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    wget -P /tmp/go https://go.dev/dl/go3.22.5.linux-amd64.tar.gz /tmp/go
    sudo tar -C /usr/local -xzf go3.22.5.linux-amd64.tar.gz
fi

read -p "Do you want install vscode? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    wget -P /tmp/go https://go.dev/dl/go3.22.5.linux-amd64.tar.gz /tmp/go
    sudo tar -C /usr/local -xzf go3.22.5.linux-amd64.tar.gz
fi

read -p "Do you want install rust lang? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

# @neovim
read -p "Do you want install neovim? [y/n]: " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  dir="$HOME/code/neovim"
  [ ! -d $dir ] && git clone https://github.com/neovim/neovim.git $dir
  cd $HOME/code/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
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

    ### Add Fonts for Waybar ###
    mkdir -p $HOME/Downloads/nerdfonts/
    cd $HOME/Downloads/
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
    unzip '*.zip' -d $HOME/Downloads/nerdfonts/
    rm -rf *.zip
    sudo cp -R $HOME/Downloads/nerdfonts/ /usr/share/fonts/

    fc-cache -rv  

    
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
  sudo nala install -y pipewire, pipewire-pulse, pipewire-media-session 
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
    sudo nala install -y  gnu-free-fonts noto-fonts ttf-jetbrains-mono
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

