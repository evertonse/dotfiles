
# gcompat forcompatibilitie with glibc programs that relies on ld-linux.*.so

sudo xbps-install gcompat base-devel
sudo xbps-install -S bat fzf fd ripgrep

# NOTE: The recommended way is throught rustup stuff, bleh
# sudo xbps-install cargo rust rustup
# rustup default nightly

sudo lua-devel

