#!/bin/sh

# Extra directories to scan, space-separated
EXTRA_DIRS="/usr/local/bin /opt/scripts"

# Process PATH and EXTRA_DIRS without changing IFS
build_dir_list() {
    # Start with PATH directories
    for path_dir in $(printf %s "$PATH" | tr ':' ' '); do
        if [ -d "$path_dir" ]; then
            echo "$path_dir"
        fi
    done
    
    # Add extra directories
    for extra_dir in $EXTRA_DIRS; do
        if [ -d "$extra_dir" ]; then
            echo "$extra_dir"
        fi
    done
}

# Get unique directories
DIRS=$(build_dir_list | sort | uniq)
echo "Going through these directories:"
echo "$DIRS"
echo ""

# Function to check if a file has sh shebang
has_sh_shebang() {
    # Read first line without command substitution to avoid null byte issue
    first_line=""
    if [ -f "$1" ] && [ -r "$1" ]; then
        # Just read the first line directly into variable
        IFS= read -r first_line < "$1" || :
        case "$first_line" in
            '#!'*/sh | '#!'*/sh\ * | '#!sh' | '#!sh\ '*)
                return 0 ;;
            *)
                return 1 ;;
        esac
    else
        return 1
    fi
}

# Function to confirm continuation
confirm_continue() {
    printf "Continue? [Y/n]: "
    read -r answer
    case "$answer" in
        [Nn]*)
            echo "Exiting."
            exit 0
            ;;
    esac
}

# Check if checkbashisms exists
if ! command -v checkbashisms >/dev/null 2>&1; then
    echo "Error: checkbashisms command not found"
    exit 1
fi

# Loop through directories
for dir in $DIRS; do
    echo "Checking directory: $dir"
    
    # Find executable files
    for file in "$dir"/*; do
        # Skip if not a regular executable file
        [ -f "$file" ] && [ -x "$file" ] || continue
        
        # Check if file has sh shebang
        if has_sh_shebang "$file"; then
            printf "Checking: %s\n" "$file"
            checkbashisms "$file"
            confirm_continue
        fi
    done
done
