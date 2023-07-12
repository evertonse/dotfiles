alias tm='/bin/tmux -2 a  || /bin/tmux -2'
alias fgrep='fgrep --color=auto'
alias grep='grep -i --color=auto'
alias egrep='egrep --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias ls='ls -AF --color=always --group-directories-first'
alias ll='ls -AlF --color=always --group-directories-first'
alias l='ls -CF'
alias gdb='gdb -tui -iex "set disassembly-flavor intel"'
alias objdump='objdump -M intel'

touch2() { mkdir -p "$(dirname "$1")" && touch "$1" ; }
alias touch='touch2'

alias py='python3'
alias pip='pipx'
alias yt='youtube-dl --add-metadata -ic' # i ignore errors -c continue after a break, pickup where it started
alias yta='youtube-dl --add-metadata -xic' # Audio Only
alias YT='youtube-viewer'
