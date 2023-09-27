alias tm='/bin/tmux -2 a  || /bin/tmux -2'
alias fgrep='fgrep --color=auto'
alias grep='grep -i --color=auto'
alias egrep='egrep --color=auto'
alias pacman='pacman --color=auto'
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

# Use neovim for vim if present.
# [ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

[ -f "$MBSYNCRC" ] && alias mbsync="mbsync -c $MBSYNCRC"

#: sudo not required for some system commands
alias shutdown="killall chrome --wait;sudo poweroff;"
for command in backlight mount umount sv pacman updatedb su poweroff reboot ; do
	alias $command="sudo $command"
done; unset command

