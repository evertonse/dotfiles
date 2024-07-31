alias tm='/bin/tmux -2 a  || /bin/tmux -2'

# grep rn full path
grnf() {
  # Check if rg (ripgrep) is installed
  if command -v rg > /dev/null 2>&1; then
    # If rg is available, use it
    rg --vimgrep --color=auto "$1" "$(pwd)/$2"
  else
    grep -RrEinIH --color=auto "$1" "$(pwd)/$2"
  fi
}

# grep -rn relative path
grn() {
  # Check if rg (ripgrep) is installed
  if command -v rg > /dev/null 2>&1; then
    # If rg is available, use it
    rg --vimgrep --color=auto "$1" "$2"
  else
    grep -RrEinIH --color=auto "$1" "$2"
  fi
}


alias grep='grep -i --color=auto'

alias egrep='egrep --color=auto'
alias pacman='sudo pacman --color=auto'
alias yay='yay --color=auto'
alias ls='ls -AF --color=always --group-directories-first'
alias ll='ls -AlhF --color=always --group-directories-first'
alias l='ls -CF'
alias gdb='gdb -tui -iex "set disassembly-flavor intel"'
alias objdump='objdump -M intel'
alias py='python3'
# alias yt='youtube-dl --add-metadata -ic' # i ignore errors -c continue after a break, pickup where it started
# alias yta='youtube-dl --add-metadata -xic' # Audio Only
alias yt='yt-dlp --add-metadata -ic' # i ignore errors -c continue after a break, pickup where it started
alias yta='yt-dlp --add-metadata -xic' # Audio Only
alias YT='youtube-viewer'
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvim-chad='NVIM_APPNAME="nvim-chad" nvim'

# Use neovim for vim if present.
# [ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

[ -f "$MBSYNCRC" ] && alias mbsync="mbsync -c $MBSYNCRC"

#: sudo not required for some system commands
alias shutdown="killall chrome --wait;sudo poweroff;"
for command in backlight mount umount sv updatedb su poweroff; do
	alias $command="sudo $command"
done; unset command

alias reboot="pkill -2 chrome; sudo reboot"
 

