# Put what you want to run at startup here, should be shell posix compliant and be located at $HOME/start.sh
# You can use every function and variabe defined in zprofile or profile or login.sh or whatever it's called the login script for your shell

start() {
  pidof -sx "$1" > /dev/null 2> /dev/null || "$@" &
}

# start tmux
start light 30


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
