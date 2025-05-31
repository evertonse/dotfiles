#!/bin/sh

#
# Put what you want to run at startup here, should be shell posix compliant and be located at $HOME/start.sh
# You can use every function and variabe defined in zprofile or profile or login.sh or whatever it's called the login script for your shell
#

safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/exports/init.sh"
if grep -i Microsoft /proc/version >/dev/null 2>&1; then
  safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/wsl/login.sh"
fi

vim_runtime_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim/runtime/"

# Check if the file exists
if [ -e "$vim_runtime_dir" ]; then
    export VIMRUNTIME="$vim_runtime_dir"
fi

# From here onwards it's only relevant if not on WSL
if [ -n $WSL ]; then
    exit 0
fi


# start tmux
safe_start light -S 30

# Check if DISPLAY is unset and if the current terminal is /dev/tty1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    #
    # Uncomment to start you're window manager executable
    # Or jsut uncomment startx IF you have `xinitrc` setup
    #
    # After starting X11 THEN it runs xinitrc with DISPLAY set.
    # That means you'll be able to call x's functions such as xmodmap xset
    #

    # exec "$WM_EXEC" &> /dev/null
    exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
fi

echo "login.sh setup correctly" > /tmp/shell.log
