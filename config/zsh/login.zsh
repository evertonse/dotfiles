
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/login.sh"

vim_runtime_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim/runtime/"

# Check if the file exists
if [ -e "$vim_runtime_dir" ]; then
    export VIMRUNTIME="$vim_runtime_dir"
fi
