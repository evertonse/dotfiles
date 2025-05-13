
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/interactive.sh"

stty stop undef # Disable ctrl-s to freeze terminal.
stty -ixon

# To check for scripts that should be posix compliant
# Install checkbashisms.
# checkbashisms ~/.config/shell/**.sh
# ln -sfT dash /usr/bin/sh

# Enable colors and change prompt:
autoload -U colors && colors    # Load colors

# When using bash you could have this
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd   # Automatically cd into typed directory.
setopt interactive_comments
setopt MENU_COMPLETE
unsetopt flow_control

# Hash holding paths that shouldn't be grepped (globbed) – blacklist for slow disks, mounts, etc.:
typeset -gA FAST_BLIST_PATTERNS
FAST_BLIST_PATTERNS[/mnt/*/**]=1
ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/*)


# The .profile should take case of this, but it doesn't get sourced every in WSL only /etc/profile.
# .zprofile on the other hand gets sourced once and login (from a login shell they call it)
# .zprofile should just source aliases and exports, variables and so on, things that aren't interactive
# See: https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where
ZPROFILE_PATH="$HOME/.zprofile"
if [ ! -f "$ZPROFILE_PATH" ]; then
  echo ".zprofile haven't been zetup correctly"
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases.sh"
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/variables.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/variables.sh"
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/wsl.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/wsl.sh"
fi


# History in cache directory:
setopt inc_append_history      # Append to history file immediately
setopt share_history           # Share history between terminals
setopt extended_history        # Save timestamp with commands
setopt hist_ignore_all_dups    # Remove older duplicates
setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicates first when trimming
setopt HIST_IGNORE_DUPS        # Don't store consecutive duplicates
setopt SHARE_HISTORY           # Share history between terminals (duplicate)
export HISTSIZE=10000          # Mem history size (POSIX compatible)
export SAVEHIST=10000          # File history size (ZSH specific)


if [ -n "$TMUX" ]; then
  window_name=$(tmux display-message -p '#W' 2>/dev/null)
  [ -z "$window_name" ] && window_name="zsh"
fi

[ -d "$XDG_DATA_HOME/history" ] || mkdir -p "$XDG_DATA_HOME/history" 2>/dev/null


[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/fsh/fast-syntax-highlighting.plugin.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/fsh/fast-syntax-highlighting.plugin.zsh"





# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)        # Include hidden files.
setopt NO_BEEP

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

# Define a custom widget to clear the line and open nvim
function clear_and_nvim {
  # Clear the curret line
  zle kill-whole-line
  # Insert the command
  LBUFFER="nvim-0.11"
  # Simulate pressing Enter
  zle accept-line
}

function clear_and_exit {
  # Clear the current line
  zle kill-whole-line
  # Insert the command
  LBUFFER="exit"
  # Simulate pressing Enter
  zle accept-line
}

function clear_and_tmux {
  zle kill-whole-line
  LBUFFER="tmux -2 a  || tmux -2"
  zle accept-line
}

function accept-line-and-run() {
    # Simulate pressing Ctrl + L to accept the autosuggestion
    # zle complete-word
    zle autosuggest-accept
    # # Provide a visual feedback delay (adjust the sleep duration as needed)
    sleep 0.1
    zle redisplay
    # # Simulate pressing Enter to accept and execute the command
    zle accept-line
}

zle -N accept-line-and-run
# Reason for line below is explained by by: https://unix.stackexchange.com/questions/740102/end-of-line-widget-not-working-in-functions-zsh-autosuggestions
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(accept-line-and-run)

# Bind the custom widget to Ctrl+n
zle -N clear_and_nvim
zle -N clear_and_exit
zle -N clear_and_tmux
bindkey '^t'  clear_and_tmux
# ^[ is basically Alt
bindkey '^[n' clear_and_nvim
bindkey '^q' clear_and_exit

bindkey -s ^f "tmux-sessionizer\n"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Map Ctrl+S to history search in vi insert mode

# bindkey '^S' accept-line-and-run # TODO: crtl+s is too useful to be wasted, make a use of it
bindkey -M viins '^S' history-incremental-search-backward
# bindkey '^S' history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^y' accept-line-and-run
bindkey '^L' autosuggest-accept
bindkey '^H' backward-delete-char

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^K' kill-line
# bindkey -M viins '^K' kill-line  # for vi insert mode


bindkey '\t' expand-or-complete

bindkey '^[[Z' reverse-menu-complete
bindkey "^E" forward-word
bindkey "^B" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -s '^G' '^u$EXPLORER .^M'

# Create a custom "g-prefix" widget for vicmd
vi_g_prefix_widget() {
  local key
  read -k key  # Read the next key after 'g'

  case "$key" in
    l)
      zle end-of-line
      ;;
    h)
      zle beginning-of-line
      ;;
    *)
      # Put the keys back into the buffer for default handling
      zle send-break
      zle -U "g$key"
      ;;
  esac
}

zle -N vi_g_prefix_widget

# Bind 'gh' to move to beginning of line
# Bind 'g' in vicmd to our custom prefix widget
# Bind 'gl' to move to end of line
bindkey -M vicmd 'g' vi_g_prefix_widget



###########################################################################################################################
# Prompt
###########################################################################################################################
# Enables prompt command substitution — functions and variables inside the prompt are re-evaluated each time the prompt is drawn.
setopt PROMPT_SUBST

# Function to get the current Git branch name, if any
git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [[ -n $branch ]]; then
        echo " ($branch)"
    fi
}

#3k
get_terminal_width() {
    tput cols
}

visible_length() {
    local text="$1"
    # Strip % escapes and control characters
    echo -n "$text" | sed -E 's/%\{[^}]*\}//g; s/%[[:alpha:]]//g' | wc -c
}

ZSH_FIRST_PROMPT=1
function exit_code_indicator() {
    local code=$?
    if [[ $ZSH_FIRST_PROMPT -eq 123123 ]]; then
        echo "[%F{green}0%f]"
    elif [[ $code -eq 0 ]]; then
        echo "[%F{green}$code%f]"
    elif [[ $code -eq 130 ]]; then
        echo "[%F{yellow}$code%f]"
    else
        echo "[%F{red}$code%f]"
    fi
}


git_branch() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo "($branch)"
}

current_time() {
    date +%T
}

# This is run before each prompt, in the main shell (not a subshell)
# precmd() {
#     ZSH_FIRST_PROMPT=0
# }

space_filler() {
    local username="$USER"
    local cwd="${PWD/#$HOME/~}"
    local left="[$username @ $cwd]"

    local exitcode=$(exit_code_indicator)
    local gitinfo=$(git_branch)
    local timeinfo=$(current_time)

    local total_width=$(get_terminal_width)
    local left_len=$(visible_length "$left")
    local right_text="$exitcode $gitinfo $timeinfo"
    local right_len=$(visible_length "$right_text")

    local filler_len=$(( total_width - left_len - right_len - 2 ))
    [[ $filler_len -lt 0 ]] && filler_len=0

    printf '%*s' "$filler_len" '' | tr ' ' ' '
}
# Use single quotes for PROMPT and RPROMPT so that embedded functions/variables are evaluated at prompt time (not once when the shell starts)
# %n = username, %~ = current directory, %T = time, %B/%b = bold on/off
NEWLINE=$'\n'
PROMPT='[%n @ %B%~%b]${NEWLINE}$ '
# PROMPT='${NEWLINE}$ '
RPROMPT='$(exit_code_indicator) $(git_branch) %T'
###########################################################################################################################


###########################################################################################################################
# For when in Graphical env
###########################################################################################################################
# [[ -z $DISPLAY ]] && { mkdir -p "$HOME/.local/state" && source ~/.config/shell/startup.sh > "$HOME/.local/state/startup.log" &>/dev/null; } &>/dev/null &
# [[ -z $DISPLAY ]] && setsid bash -c '({ mkdir -p "$HOME/.local/state" && source ~/.config/shell/startup.sh &> "$HOME/.local/state/startup.log" &>/dev/null; } &>/dev/null)' &> /dev/null
# [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] &&  exec $WM_EXEC &> /dev/null
###########################################################################################################################

