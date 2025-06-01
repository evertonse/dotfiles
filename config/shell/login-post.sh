# This file also runs only once, but after zshrc (interactive)

# From here onwards it's only relevant if not on WSL
if grep -i Microsoft /proc/version > /dev/null 2>&1; then
    echo "Login Post on WSL event works" > /tmp/login-post.log
    return 0
fi


echo "Login Post works" > /tmp/login-post.log
