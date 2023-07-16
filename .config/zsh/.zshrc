stty stop undef		# Disable ctrl-s to freeze terminal.
stty -ixon
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/sh/aliases.sh
source ~/.config/sh/vars.sh


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

touch2() { mkdir -p "$(dirname "$1")" && touch "$1" ; }


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
bindkey "^L" forward-word
bindkey "^H" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
