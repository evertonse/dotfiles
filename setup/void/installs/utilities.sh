
# gcompat forcompatibilitie with glibc programs that relies on ld-linux.*.so

sudo xbps-install base-devel gcc g++ clang clangd
sudo xbps-install -S bat fzf fd ripgrep

sudo xbps-install -S fzy curl wget
sudo xbps-install -S python luarocks tmux
sudo xbps-install -S yazi


# NOTE: The recommended way is throught rustup stuff, bleh
# sudo xbps-install cargo rust rustup
# rustup default nightly

# sudo lua-devel

