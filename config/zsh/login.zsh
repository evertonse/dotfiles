
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/login.sh"

nvim_runtime_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim/runtime/"

# Check if the file exists
if [ -e "$nvim_runtime_dir" ]; then
    export NVIMRUNTIME="$nvim_runtime_dir"
fi

# Following automatically calls "startx" when you login on tty1:
if [[ -z ${DISPLAY} && ${XDG_VTNR} -eq 1 ]]; then
    # Logs can be found in ~/.xorg.log
    exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
fi
