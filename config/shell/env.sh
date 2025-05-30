# Usage: safe_source filename
safe_source () {
    if [ -r "$1" ]; then
        . "$1"
    fi
}

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/utils/append.sh"

umask 0077
