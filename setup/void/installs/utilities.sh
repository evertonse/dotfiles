
# gcompat forcompatibilitie with glibc programs that relies on ld-linux.*.so

sudo xbps-install gcompat base-devel
sudo xbps-install -S bat fzf fd ripgrep
sudo xbps-install -S xorg xfce4

# NOTE: The recommended way is throught rustup stuff, bleh
# sudo xbps-install cargo rust rustup
# rustup default nightly

# sudo lua-devel

