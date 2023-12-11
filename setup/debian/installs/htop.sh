CLONEDIR="$HOME/code/htop-vim"
pushd
git clone https://github.com/KoffeinFlummi/htop-vim.git $CLONEDIR
cd $CLONEDIR
./autogen.sh && ./configure && make
sudo rm -f "$HOME/.local/bin/htop"
sudo rm -f "/bin/htop"
sudo rm -f "/usr/bin/htop"
sudo ln -sf "$CLONEDIR/htop" "$HOME/.local/bin/htop"
popd

