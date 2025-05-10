#!/bin/sh

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/exports.sh"
if grep -i Microsoft /proc/version >/dev/null 2>&1; then
  safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/wsl-login.sh"
fi

echo "login.sh setup correctly" >> /tmp/shell.log
