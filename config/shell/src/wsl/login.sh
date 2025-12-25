#!/usr/bin/sh

export WSL="true"
export WINDOWS_DRIVER_PATH="/mnt/c" # Assuming C:\ Always
export WINDOWS_SYSTEM32="$WINDOWS_DRIVER_PATH/Windows/System32/"

# Lets add theses one path in case 'appendWindowsPath' isn't 'true'
# Important for yanking with win32yank.exe which currently is in /mnt/c/Windows/System32/win32yank.exe
# pathappend "$WINDOWS_DRIVER_PATH/Windows/System32/" PATH

# NOTE: Certain Paths is too bad too include because programs try tries to keeping reading it and getting blocked
#       Helix editor is one of them, it just HANGS a fuck ton until I remove something from PATH that is using 9p protocol.
# pathappend "$WINDOWS_DRIVER_PATH/Windows/" PATH

export WIN_USER=$($WINDOWS_SYSTEM32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
if [ -z "$WIN_USER" ]; then
    WIN_USER="Administrator"
fi

export WIN_USERPROFILE="/mnt/c/Users/$WIN_USER/"
export WIN_DOWNLOADS="/mnt/c/Users/$WIN_USER/Downloads"



##################################
## Tryin to squeeze performance
# echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop
# unset WSL_INTEROP
# To re-enable Windows binaries, exit all WSL sessions and re-run bash.exe or run the following command as root:
# echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop

# export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
DISPLAY_IP=$(ip route list default | awk '{print $3}')
export DISPLAY="$DISPLAY_IP:0" # Only one that worked
export LIBGL_ALWAYS_INDIRECT=1

export GDK_BACKEND=x11
 
is_blacklisted() {
    case "$1" in
        /mnt/*) return 0 ;; # Path is blacklisted
        *) return 1 ;; # Path is not blacklisted
    esac
}

# Function to filter out Windows paths from PATH
disable_windows_path='false'
filter_windows_path() {
    echo "$PATH" | sed 's/:/\n/g' | grep -v '/mnt/c' | paste -sd: -
}

# Check if disable_windows_path is true
if [ "$disable_windows_path" = 'true' ]; then
    PATH=$(filter_windows_path)
fi

if ! command -v tmux &> /dev/null; then
    return 0
fi

# Tmux server is already running, nothing to do.
if pgrep -x "tmux" > /dev/null; then
    return 0
fi

# Check if the tmux session named 'code' exists
if ! tmux has-session -t code 2>/dev/null; then
    # Start a new tmux session named 'code' in detached mode
    tmux new-session -d -s code
fi

