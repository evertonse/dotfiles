
# gcompat forcompatibilitie with glibc programs that relies on ld-linux.*.so

sudo xbps-install -Sy base-devel gcc clang clangd
sudo xbps-install -Sy bat fzf fd ripgrep

sudo xbps-install -Sy fzy curl wget
sudo xbps-install -Sy python luarocks tmux
sudo xbps-install -Sy yazi

sudo xbps-install -Sy brillo


# NOTE: The recommended way is throught rustup stuff, bleh
# sudo xbps-install cargo rust rustup
# rustup default nightly

# sudo lua-devel

