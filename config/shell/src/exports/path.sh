#!/usr/bin/sh


if [ -z $TMUX ]; then
    pathappend "$CARGO_HOME/bin" PATH
    pathappend "$RUSTUP_HOME/bin" PATH

    pathappend "$HOME/.local/bin" PATH
    pathappend "$HOME/.local/bin/statusbar/" PATH
    pathappend "$XDG_DATA_HOME/go/bin/" PATH
    pathappend "$XDG_DATA_HOME/cargo/bin" PATH
    pathappend "$XDG_DATA_HOME/flutter/bin" PATH
    pathappend "$XDG_DATA_HOME/android-studio/bin" PATH
else
    pathremove "$HOME/.local/bin/statusbar/" PATH
    pathappend "$XDG_DATA_HOME/flutter/bin" PATH
    pathremove "$XDG_DATA_HOME/android-studio/bin" PATH
fi
