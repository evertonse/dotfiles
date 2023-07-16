# @basic

installpkg() {
	pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}

echo " This script assumes every git clone will be placed under ~/code folder"
echo " if this folder already has a certain repo, no action will be taken"
for x in curl ca-certificates base-devel git ntp zsh make cmake wget unzip npm ripgrep fd libxft go; do
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
  git clone https://github.com/radare/radare2 ~/code/radare 
  cd ~/code/radare 
  sh sys/install.sh
fi

# @yay
read -p "Do you want install yay? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/code/yay && cd ~/code/yay && makepkg -si
fi

# @neovim
read -p "Do you want install neovim? [y/n]: " answer
if [ "$answer" = "y" ]; then
  git clone https://github.com/neovim/neovim.git ~/code/neovim && cd ~/code/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
fi

# @x11 stuff

read -p "Do you want install X11 stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --noconfirm xcb-proto xcb-util xcb-util-wm xcb-util-cursor xcb-util-keysyms
  sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xsetroot xorg-xbacklight
fi

read -p "Do you want install suckless and rocks stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  git clone https://github.com/evertonse/rocks.git ~/code/rocks && cd ~/code/rocks && ./install.sh
fi

read -p "Do you want install the notification daemon 'dunst' stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  git clone https://github.com/dunst-project/dunst.git ~/code/dunst && cd ~/code/dunst && make && sudo make install
fi


# @user pkg
sudo pacman -S --noconfirm zathura glow lf mpv zsh tmux
#sudo pacman -S neovim --noconfirm
# python-pywal -> wal
sudo pacman -S --noconfirm xwallpaper picom python-pywal ueberzug
sudo pacman -S --noconfirm fd ripgrep flameshot sysstat wget  netctl networkmanager 
yay --noconfirm vivid 
yay --noconfirm noto-fonts-emoji
yay --noconfirm Imlib2
yay --noconfirm nsxiv

read -p "Do you want install the notification pulseaudio and tui related to audio stuff? [y/n]: " answer
if [ "$answer" = "y" ]; then
  sudo pacman -S --noconfirm  pulseaudio pulseaudio-equalizer pavucontrol  pamixer
  # look https://github.com/GeorgeFilipkin/pulsemixer
  #curl https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer > pulsemixer && chmod +x ./pulsemixer
  # look https://github.com/fulhax/ncpamixer
  yay --noconfirm ncpamixer pulsemixer ncmpcpp 
fi

read -p "Do you want install nerdfonts? [y/n]: " answer
if [ "$answer" = "y" ]; then
  yay --noconfirm nerd-fonts-complete-mono-glyphs ttf-jetbrains-mono-nerd
fi

go install github.com/darkhz/bluetuith@latest
