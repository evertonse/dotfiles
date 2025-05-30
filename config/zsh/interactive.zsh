
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/interactive.sh"

stty stop undef # Disable ctrl-s to freeze terminal.
stty -ixon

# INFO:
#      ´zle -al´ to see all them commands
#      ´set -o´  give a list of thy options


setopt nocorrect                  # No Auto correct mistakes
setopt extendedglob               # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                 # Case insensitive globbing
setopt rcexpandparam              # Array expension with parameters
# setopt nocheckjobs                # Don't warn about running processes when exiting
setopt numericglobsort            # Sort filenames numerically when it makes sense
setopt nobeep                     # No beep
setopt histignorealldups          # If a new command is a duplicate, remove the older one
setopt histignorespace            # Don't save commands that start with space
setopt appendhistory              # Immediately append history instead of overwriting
setopt autocd                     # if only directory path is entered, cd there.

# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete    # Autocmp first menu match
setopt auto_param_slash           # When a dir is completed, add a / instead of a trailing space
setopt noautoremoveslash          # When canceling keep the slash /
setopt no_case_glob no_case_match # Make cmp case insensitive
setopt globdots                   # Include dotfiles
setopt extended_glob              # Match ~ # ^
setopt interactive_comments       # Allow comments in shell
unsetopt prompt_sp                # Don't autoclean blanklines

# To check for scripts that should be posix compliant
# Install checkbashisms.
# checkbashisms ~/.config/shell/**.sh
# ln -sfT dash /usr/bin/sh

# Enable colors and change prompt:
autoload -U colors && colors    # Load colors

# When using bash you could have this
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "


# Check if the /mnt directory exists and is a directory
if [[ -d /mnt && "$(ls -A /mnt)" ]]; then
    # Add to the blacklist if the directory exists and is not empty
    ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/*)
fi

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


# fzf setup
if command -v fzf >/dev/null 2>&1; then
  safe_source <(fzf --zsh) # allow for fzf history widget
fi

# History in cache directory:
setopt append_history   # better history
setopt inc_append_history      # Append to history file immediately
setopt share_history           # Share history between terminals
setopt extended_history        # Save timestamp with commands
setopt hist_ignore_all_dups    # Remove older duplicates
setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicates first when trimming
setopt HIST_IGNORE_DUPS        # Don't store consecutive duplicates
export HISTSIZE=10000          # Mem history size (POSIX compatible)
export SAVEHIST=10000          # File history size (ZSH specific)

# bindkey '^s' fzf-history-widget
# bindkey -M viins '^S' history-incremental-search-backward
bindkey -M viins '^S' fzf-history-widget
bindkey -M vicmd '^[n' clear_and_nvim
bindkey -M vicmd 'U' 'redo'
# bindkey '^S' history-incremental-search-backward


if [ -n "$TMUX" ]; then
  window_name=$(tmux display-message -p '#W' 2>/dev/null)
  [ -z "$window_name" ] && window_name="zsh"
fi

[ -d "$XDG_DATA_HOME/history" ] || mkdir -p "$XDG_DATA_HOME/history" 2>/dev/null
export HISTFILE="$XDG_DATA_HOME/history/history_${window_name}"





###########################################################################################################################
# Autocomplete
###########################################################################################################################

# Initialize completion system first
# autoload -U compinit colors zcalc   # theming
autoload -Uz compinit
compinit

# Basic auto/tab complete:
# unsetopt flow_control
setopt NO_BEEP

zmodload zsh/complist
_comp_options+=(globdots)        # Include hidden files (fixed syntax)


setopt  completeinword
setopt  ALWAYS_TO_END            # Move cursor to end after completion
setopt  MENU_COMPLETE         # Select first match immediately

zstyle ':completion:*' completer _prefix _complete _match _ignored _approximate _files _directories
# zstyle ':completion:*' completer _complete _match _ignored _approximate
zstyle ':completion:*' use-cache
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' squeeze-slashes false

# This is the key: truncate the unmatched suffix

# Configure completion system with proper quotes around values
# zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# zstyle ':completion:*' matcher-list '' 'r:|[._-]=**' 'l:|=* r:|=*'
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Extra  bash-like completion explicitly
zstyle ':completion:*' accept-exact true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' insert-tab true
zstyle ':completion:*' insert-unambiguous true

zstyle ':completion:*' expand yes prefix
# zstyle ':completion:*' expand suffix

# Additional settings to make completion more aggressive
zstyle ':completion:*' show-ambiguity true
zstyle ':completion:*' list-suffixes  true
zstyle ':completion:*' path-completion true

function complete-and-trim-tail() {
  # Save initial cursor and buffer state
  local OLD_CURSOR=$CURSOR OLD_BUFFER=$BUFFER

  # Trigger completion
  zle expand-or-complete-prefix

  # Only trim if cursor moved and the next character is not a space
  if [[ $CURSOR -ne $OLD_CURSOR ]]; then
    local next_char=${BUFFER[$CURSOR+1]}
    if [[ -n $next_char && $next_char != [[:space:]] ]]; then
      zle kill-word
    fi
  fi
  zle redisplay
}


zle -N complete-and-trim-tail

bindkey '^I' complete-and-trim-tail  # Bind to Tab (Ctrl+I)
# bindkey '\t' expand-or-complete    # Old

function menu_cancel_to_normal_mode() {
  zle send-break       # Exit the completion menu
  zle vi-cmd-mode      # Switch to normal mode
}
zle -N menu_cancel_to_normal_mode

# Unused
function accept_menu_and_normal_mode() {
  zle .accept-and-hold        # Accept current menu selection (does not run line)
  zle vi-cmd-mode             # Switch to normal mode
}

zle -N accept_menu_and_normal-mode

bindkey -M menuselect '\e' menu_cancel_to_normal_mode

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

###########################################################################################################################


###########################################################################################################################
# keymap
###########################################################################################################################
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
  LBUFFER="nvim"
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


# vi mode
bindkey -v
export KEYTIMEOUT=1


# DONE: fix why ctrl+w is so slow
# Smart delete word function for Zsh
# Behaves like Ctrl+W in Vim - stops at symbols and non-word characters
smart-delete-word() {
    local WORDCHARS_ORIG="$WORDCHARS"
    
    # Temporarily modify WORDCHARS to exclude symbols
    # This makes word boundaries stop at symbols like /, ., @, #, etc.
    WORDCHARS=""
    
    # If we're at the beginning of the line or after whitespace,
    # delete any leading whitespace first
    if [[ $CURSOR -gt 0 ]]; then
        local char_before="${BUFFER[CURSOR]}"
        if [[ "$char_before" == " " || "$char_before" == $'\t' ]]; then
            # Delete trailing whitespace
            while [[ $CURSOR -gt 0 && ("${BUFFER[CURSOR]}" == " " || "${BUFFER[CURSOR]}" == $'\t') ]]; do
                ((CURSOR--))
            done
            BUFFER="${BUFFER[1,CURSOR]}${BUFFER[CURSOR+1,-1]}"
        else
            # Use backward-delete-word with modified WORDCHARS
            zle backward-delete-word
        fi
    fi
    
    # Restore original WORDCHARS
    WORDCHARS="$WORDCHARS_ORIG"
}

zle -N smart-delete-word

bindkey '^w' smart-delete-word

# Alternative bindings you might want to try:
# bindkey '^[^?' smart-delete-word  # Alt+Backspace
# bindkey '^H' smart-delete-word    # Ctrl+H

# Optional: Bind to a different key like Ctrl+Backspace
# bindkey '^[[3;5~' smart-delete-word  # Common Ctrl+Backspace sequence
# bindkey '^?' smart-delete-word       # Alternative Ctrl+Backspace



bindkey -v '^?' backward-delete-char

bindkey '^y' accept-line-and-run
bindkey '^L' autosuggest-accept
bindkey '^H' backward-delete-char
# bindkey '^w' kill-word

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^K' kill-line
# bindkey -M viins '^K' kill-line  # for vi insert mode


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
# Plugins
###########################################################################################################################
# safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# TODO: fast-syntax-highlighting stops highlighting when I press tab. Find out more about it
safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"


# Check if the /mnt directory exists and is a directory
if [[ -d /mnt && "$(ls -A /mnt)" ]]; then
    typeset -gA FAST_BLIST_PATTERNS
    FAST_BLIST_PATTERNS[/mnt/*/**]=1
fi

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"


###########################################################################################################################
# For when in Graphical env
###########################################################################################################################
# [[ -z $DISPLAY ]] && { mkdir -p "$HOME/.local/state" && source ~/.config/shell/startup.sh > "$HOME/.local/state/startup.log" &>/dev/null; } &>/dev/null &
# [[ -z $DISPLAY ]] && setsid bash -c '({ mkdir -p "$HOME/.local/state" && source ~/.config/shell/startup.sh &> "$HOME/.local/state/startup.log" &>/dev/null; } &>/dev/null)' &> /dev/null
# [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] &&  exec $WM_EXEC &> /dev/null
###########################################################################################################################

