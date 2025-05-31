# Usage: safe_source filename
safe_start() {
    # Check if the command is provided
    if [ -z "$1" ]; then
        echo "Error: No command provided." >> /tmp/env.log
        return 1
    fi

    # Check if the command exists
    if ! command -v "$1" > /dev/null 2>&1; then
        echo "Error: Command '$1' not found." >> /tmp/env.log
        return 1
    fi

    # Check if the process is already running
    if ! pidof -sx "$1" > /dev/null 2>&1; then
        # Start the command in the background
        "$@" &
    else
        echo "$1 is already running." >> /tmp/env.log
    fi
}

safe_source () {
    if [ -r "$1" ]; then
        . "$1"
    fi
}

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/utils/append.sh"
