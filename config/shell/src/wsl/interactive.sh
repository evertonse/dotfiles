#!/usr/bin/sh
if ! command -v wsl-open > /dev/null 2>&1; then
  echo 'you'"'"'re using wsl, but does not have wsl-open, which is a pretty good utility to open win10+ apps from wsl'
fi

alias open='wsl-open'
alias explorer="$WINDOWS_DRIVER_PATH/Windows/explorer.exe"
alias cmd="$WINDOWS_DRIVER_PATH/Windows/System32/cmd.exe"

exe() {
    cmd_output=$(wslpath $(cmd.exe /c where "$1" 2>/dev/null))
    target=$(echo "$cmd_output" | sed -e 's/\r$//' | head -n 1)
    # Echo for debug
    # echo $target
    if [ "$target" = "." ]; then
        echo "Command '$1' not found."
    else
        shift
        "$target" "$@"
    fi
}
