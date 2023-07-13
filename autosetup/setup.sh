# @basic
sudo pacman -Syu --noconfirm git make cmake

# @firmware
sudo pacman -Syu --noconfirm fwupd
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

# @radare
git clone https://github.com/radare/radare2 ~/code/radare && cd ~/code/radare && sh sys/install.sh
# @yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/code/yay && cd ~/code/yay && makepkg -si
# @neovim
git clone https://github.com/neovim/neovim.git ~/code/neovim && cd ~/code/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

# linux idk you'll need
sudo pacman -S base-devel linux linux-headers linux-api-headers linux-firmware linux-docs --noconfirm
# @x11 stuff
sudo pacman -S --noconfirm xcb-proto xcb-util xcb-util-wm xcb-util-cursor xcb-util-keysyms
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xsetroot

# @user pkg
sudo pacman -S --noconfirm zathura
sudo pacman -S glow --noconfirm
sudo pacman -S lf --noconfirm
sudo pacman -S mpv --noconfirm
sudo pacman -S zsh --noconfirm
#sudo pacman -S neovim --noconfirm
# python-pywal -> wal
sudo pacman -S xwallpaper picom python-pywal ueberzug --noconfirm
sudo pacman -S tmux --noconfirm
yay --noconfirm vivid fd ripgrep


