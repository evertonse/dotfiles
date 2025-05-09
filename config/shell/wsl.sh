
# WSL: Check if we're in wsl
if [[ $(grep -i Microsoft /proc/version) ]]; then
    # Append unique
    append_path () {
        case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                PATH="${PATH:+$PATH:}$1"
        esac
    }

    WINDOWS_DRIVER_PATH="/mnt/c" # Assuming C:\
    alias explorer="$WINDOWS_DRIVER_PATH/Windows/explorer.exe"
    alias cmd="$WINDOWS_DRIVER_PATH/Windows/System32/cmd.exe"

    # Lets add this this one path in case 'appendWindowsPath' isn't 'true'
    # Important for yanking with win32yank.exe
    # TODO check if this makes it slow and fix why is it being added twice
    append_path "$WINDOWS_DRIVER_PATH/Windows/System32/"

    export WIN_USER=$(cmd /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
    export WIN_USERPROFILE="/mnt/c/Users/$WIN_USER/"
    export WIN_DOWNLOADS="/mnt/c/Users/$WIN_USER/Downloads"

    export GDK_BACKEND=x11


    ## Tryin to squeeze performance
    # echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop
    # unset WSL_INTEROP
    # To re-enable Windows binaries, exit all WSL sessions and re-run bash.exe or run the following command as root:
    # echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop


    # export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0
    # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    export DISPLAY=$(ip route list default | awk '{print $3}'):0 # Only one that worked
    export LIBGL_ALWAYS_INDIRECT=1
    # IMPORTANT: RUN Xming and XLaunch/VcXsrv using the -ac flag.

    if ! command -v wsl-open > /dev/null; then
      echo 'your using wsl, but does not have wsl-open, which is a pretty good utility to open win10+ apps from wsl'
    fi
    alias open='wsl-open'
    # facilitate windows executable interop
    function exe {
        target=$(wslpath "$(awk -F$'\r' 'NR == 1 {printf "%s", $1}' <<< $(/mnt/c/Windows/System32/cmd.exe /c where $1 2>/dev/null))")
        if [[ "$target" == "." ]]; then
            echo "Command '$1' not found."
        else
            $target ${@:2}
        fi
    }

    # Hash holding paths that shouldn't be grepped (globbed) – blacklist for slow disks, mounts, etc.:
    typeset -gA FAST_BLIST_PATTERNS
    FAST_BLIST_PATTERNS[/mnt/*/**]=1
    ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/*)


    # Function to filter out Windows paths from PATH
    disable_windows_path='false'
    filter_windows_path() {
        PATH=$(echo $PATH | sed s/:/\\n/g | grep -v '/mnt/c' | sed ':a;N;$!ba;s/\n/:/g')
    }

    # Check if disable_windows_path is true
    if [[ $disable_windows_path == 'true' ]]; then
        PATH=$(filter_windows_path)
    fi
fi
