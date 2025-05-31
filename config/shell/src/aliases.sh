#!/bin/sh
# POSIX-compliant aliases and functions

# Basic tmux alias
alias tm='/usr/bin/tmux -2 a || /bin/tmux -2'
alias vim='VIMRUNTIME=;vim'

# tmfzf function
tmfzf() {
  /usr/bin/tmux list-sessions | sed -E 's/:.*$//' | grep -v "^$(tmux display-message -p '#S')$" | fzf --reverse | xargs tmux switch-client -t
}

# tmux_last_session function
tmux_last_session() {
  LAST_TMUX_SESSION=$(tmux list-sessions | awk -F ":" '{print$1}' | tail -n1)
  tmux attach -t "$LAST_TMUX_SESSION"
}

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
  if command -v rg > /dev/null 2>&1; then
    rg --vimgrep --color=auto "$1" "$2"
  else
    grep -RrEinIH --color=auto "$1" "$2"
  fi
}

# Basic aliases
alias grep='grep -i --color=auto'
alias egrep='egrep --color=auto'
alias pacman='sudo pacman --color=auto'
alias yay='yay --color=auto'

# Check if 'lsd' is available

alias 'rync -Pavh'

list_cmd='ls'
if command -v lsd >/dev/null 2>&1; then
  list_cmd='lsd'
fi
alias ls="$list_cmd -AF --color=always --group-directories-first"
alias ll="$list_cmd -AlhF --color=always --group-directories-first"


alias \
c="clear" \
shell="exec $SHELL -l" \
mv="mv -i" \
rm="rm -Iv" \
df="df -h" \
du="du -h -d 1" \
k="killall" \
p="ps aux | grep $1" \

alias gdb='gdb --quiet -tui -iex "set disassembly-flavor intel"'
alias objdump='objdump -M intel'
alias py='python3'
alias yt='yt-dlp --add-metadata -ic'
alias yta='yt-dlp --add-metadata -xic'
alias YT='youtube-viewer'

# Neovim configuration aliases
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvim-chad='NVIM_APPNAME="nvim-chad" nvim'
alias nvim-11='NVIM_APPNAME="nvim-11" nvim'
alias nvim-tmp='NVIM_APPNAME="nvim-tmp" nvim'

# System command aliases
alias shutdown='killall chrome --wait;sudo poweroff;'

# Loop for sudo commands
for command in backlight mount umount sv updatedb su poweroff; do
  alias $command="sudo $command"
done

alias reboot='pkill -2 chrome; pkill -2 chromium; sudo reboot'
alias kitty='kitty --start-as maximized'


# Anime CLI function
ani() {
  # Add Windows mpv.exe path to PATH
  pathprepend $(wslpath "C:\tools\mpv-x86_64-20240910-git-f6d9313") PATH
  ani-cli
}

# Archive extraction function
uncompress() {
  if [ $# -eq 0 ]; then
    echo "Usage: uncompress <file.tar.gz|file.tar.bz2|file.tar.xz|file.tar|file.zip>"
    return 1
  fi

  for file in "$@"; do
    if [ ! -f "$file" ]; then
      echo "Error: File '$file' not found."
      continue
    fi

    case "$file" in
      *.tar.gz | *.tgz)
        tar -xzvf "$file"
        ;;
      *.tar.bz2 | *.tbz | *.tbz2)
        tar -xjvf "$file"
        ;;
      *.tar.xz | *.txz)
        tar -xJvf "$file"
        ;;
      *.tar.zst | *.tzst)
        tar --use-compress-program=unzstd -xvf "$file"
        ;;
      *.tar)
        tar -xvf "$file"
        ;;
      *.zip)
        unzip "$file"
        ;;
      *)
        echo "Error: Unsupported file format for '$file'."
        ;;
    esac
  done
}

# Archive compression function
compress() {
  if [ $# -lt 2 ]; then
    echo "Usage: compress <format> <file_or_directory>..."
    echo "Formats: tar.gz, tar.bz2, tar.xz, tar.zst, zip"
    return 1
  fi

  format=$1
  shift  # Remove the format from arguments

  # Check the provided format and compress accordingly
  case "$format" in
    tar.gz)
      tar -czvf "${1%/}.tar.gz" "$@"
      ;;
    tar.bz2)
      tar -cjvf "${1%/}.tar.bz2" "$@"
      ;;
    tar.xz)
      tar -cJvf "${1%/}.tar.xz" "$@"
      ;;
    tar.zst)
      tar --use-compress-program=zstd -cvf "${1%/}.tar.zst" "$@"
      ;;
    zip)
      zip -r "${1%/}.zip" "$@"
      ;;
    *)
      echo "Error: Unsupported format '$format'."
      echo "Supported formats: tar.gz, tar.bz2, tar.xz, tar.zst, zip"
      return 1
      ;;
  esac
}

# Conditional aliases based on existing files
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"
[ -f "$MBSYNCRC" ] && alias mbsync="mbsync -c $MBSYNCRC"
