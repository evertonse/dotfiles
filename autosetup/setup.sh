pacman -Syyuu
autoyes="$1"

installpkg() {
  echo "installing package $1"
	#pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
	sudo pacman --noconfirm --needed -S "$1"
}

echo " This script assumes every git clone will be placed under $HOME/code folder"
echo " if this folder already has a certain repo, no action will be taken"
# @basic
for x in networkmanager make cmake curl wget ca-certificates base-devel git ntp zsh unzip npm ripgrep fd libxft go; do
	installpkg "$x"
done

# @firmware
read -p "Do you want install firmware and update it with fwupd? [y/n]: " answer
if [ "$answer" = "y" ]; then
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
if [ "$answer" = "y" ]; then
  sudo pacman -S base-devel linux linux-headers linux-api-headers linux-firmware linux-docs --noconfirm
else
  echo "No action needed was done about linux stuff."
fi

# @radare

read -p "Do you want install radare ? [y/n]: " answer
if [ "$answer" = "y" ]; then
  git clone https://github.com/radare/radare2 $HOME/code/radare 
  cd $HOME/code/radare 
  sh sys/install.sh
fi

# @yay
read -p "Do you want install yay? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --needed git Base-devel
  dir="$HOME/code/yay"
  [ ! -d $dir ] && git clone https://aur.archlinux.org/yay.git $dir
  cd $dir && sudo makepkg -si
fi

# @neovim
read -p "Do you want install neovim? [y/n]: " answer
if [ "$answer" = "y" ]; then
  dir="$HOME/code/neovim"
  [ ! -d $dir ] && git clone https://github.com/neovim/neovim.git $dir
  cd $HOME/code/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
fi

# @x11 stuff

read -p "Do you want install X11 stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --noconfirm xcb-proto xcb-util xcb-util-wm xcb-util-cursor xcb-util-keysyms
  sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xsetroot xorg-xbacklight
fi

read -p "Do you want install suckless and rocks stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  dir="$HOME/code/rocks"
  [ ! -d $dir ] && git clone https://github.com/evertonse/rocks.git $dir
   cd $dir && ./install.sh
fi

read -p "Do you want install the notification daemon 'dunst' stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  dir="$HOME/code/dunst"
  [ ! -d $dir ] && git clone https://github.com/dunst-project/dunst.git $dir 
  cd $dir && make && sudo make install
fi


# @user pkg

read -p "Do you want install the user stuff (tmux, lf , zathura)? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --noconfirm zathura glow lf mpv zsh tmux mupdf
  #sudo pacman -S neovim --noconfirm
  # python-pywal -> wal
  sudo pacman -S --noconfirm xwallpaper picom python-pywal ueberzug 
  sudo pacman -S --noconfirm fd ripgrep flameshot grim sysstat wget  netctl networkmanager 
  yay --noconfirm vivid 
  yay --noconfirm Imlib2
  yay --noconfirm nsxiv
  yay --noconfirm feh
  yay --noconfirm gummy
  # @important(tdrop) https://www.youtube.com/watch?v=TbbsjyoK0J4 https://github.com/noctuid/tdrop
  yay --noconfirm tdrop
  # @important(sxhkd) https://github.com/baskerville/sxhkd
  yay --noconfirm sxhkd 
  yay --noconfirm ytfzf 
  yay --noconfirm yt-dlp
  yay --noconfirm cwitch
  yay --noconfirm rofi 
  yay --noconfirm obs
  yay --noconfirm yt-watch 
  yay --noconfirm brightness-controller
  yay --noconfirm picom-jonaburg-git # rounded corners with https://github.com/jonaburg/picom
  # @important(simple key daemon) https://github.com/baskerville/sxhkd
  git clone https://github.com/vinceliuice/Lavanda-gtk-theme $HOME/code/git/gtk-lavanda/ && cd  $HOME/code/git/gtk-lavanda/ && ./install.sh -d $HOME/.config/themes/lavanda
  sudo pacman -S --noconfirm gnome-themes-extra adwaita-qt5 adwaita-qt6 
fi

read -p "Do you want install the notification pulseaudio and tui related to audio stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --noconfirm  pulseaudio pulseaudio-equalizer pavucontrol  pamixer
  # look https://github.com/GeorgeFilipkin/pulsemixer
  #curl https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer > pulsemixer && chmod +x ./pulsemixer
  # look https://github.com/fulhax/ncpamixer
  yay --noconfirm ncpamixer
  yay --noconfirm pulsemixer 
  yay --noconfirm ncmpcpp 
fi

read -p "Do you want install nerdfonts? [y/n]: " answer
if [ "$answer" = "y" ]; then
  yay --noconfirm nerd-fonts-complete-mono-glyphs 
  yay --noconfirm ttf-jetbrains-mono-nerd
  yay --noconfirm noto-fonts-emoji
fi

read -p "Do you want install tui (bluetuith, nmtui)? [y/n]: " answer
if [ "$answer" = "y" ]; then
  go install github.com/darkhz/bluetuith@latest
  yay --noconfirm bluetuith
fi

chsh -s /usr/bin/zsh
