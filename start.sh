# Put what you want to run at startup here, should be shell posix compliant and be located at $HOME/start.sh
# You can use every function and variabe defined in zprofile or profile or login.sh or whatever it's called the login script for your shell

start() {
  pidof -sx "$1" > /dev/null 2> /dev/null || "$@" &
}


# start tmux

# Supposedly not necessary as it'll trigger by itself once x11 starts
start "${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"


# Check if DISPLAY is unset and if the current terminal is /dev/tty1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Check if WM_EXEC is set and not empty
    if [ -n "$WM_EXEC" ]; then
        # Uncomment to start you're window manager executable
        exec "$WM_EXEC" &> /dev/null
        # exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
    fi
fi
