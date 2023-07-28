stty stop undef		# Disable ctrl-s to freeze terminal.
stty -ixon
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

source ~/.config/zsh
source ~/.config/sh/aliases.sh
source ~/.config/sh/vars.sh

[[ $- != *i* ]] && return

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt HIST_EXPIRE_DUPS_FIRST

# Load aliases and shortcuts if existent.

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/sh/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/sh/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/sh/aliases.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/sh/aliases.sh"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt NO_BEEP

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
if [[ $(grep -i Microsoft /proc/version) ]]; then
  code='~/code/' 
  export GDK_BACKEND=x11
  export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0
  #export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
  LIBGL_ALWAYS_INDIRECT=1
  code='/mnt/d/code' 
  alias explorer='explorer.exe'
  if ! command -v wsl-open > /dev/null; then
    echo 'your using wsl, but does not have wsl-open, which is a pretty good utility to open win10+ apps from wsl'
  fi
  alias open='wsl-open'
fi


function tmux_last_session(){
   LAST_TMUX_SESSION=$(tmux list-sessions | awk -F ":" '{print$1}' | tail -n1);
   tmux attach -t $LAST_TMUX_SESSION
}

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('$branch') '
  fi
}
setopt prompt_subst

autoload -U colors && colors
function change_color() {
    if [[ "$?" = 0 ]]; then
    return "green"
  else
    return "red"
  fi
}

NEWLINE=$'\n'
PROMPT="[%n @ %B%~%b] ${NEWLINE}$ "
RPROMPT="$(git_branch_name)%T"

bindkey -s '^s' 'tmux_last_session ^M'
# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^n "nvim .\n"
bindkey '^[[Z' reverse-menu-complete
bindkey "^L" forward-word
bindkey "^H" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
setopt MENU_COMPLETE

[[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && exec startx &> /dev/null
