#!/usr/bin/sh
if ! command -v wsl-open > /dev/null 2>&1; then
  echo 'you'"'"'re using wsl, but does not have wsl-open, which is a pretty good utility to open win10+ apps from wsl'
fi

alias open='wsl-open'

exe() {
    cmd_output=$(cmd.exe /c where "$1" 2>/dev/null)
    first_line=$(echo "$cmd_output" | sed -e 's/\r$//' | head -n 1)
    target=$(wslpath "$first_line")
    if [ "$target" = "." ]; then
        echo "Command '$1' not found."
    else
        shift
        "$target" "$@"
    fi
}
