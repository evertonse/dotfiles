#!/bin/sh

[[ $- != *i* ]] && return

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/aliases.sh"

if grep -i Microsoft /proc/version >/dev/null 2>&1; then
    safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/wsl-interactive.sh"
fi

echo "interactive.sh setup correctly" >> /tmp/shell.log
