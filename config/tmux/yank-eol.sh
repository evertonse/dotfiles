#!/bin/sh
tmux send-keys -X set-mark
tmux send-keys -X begin-selection
tmux send-keys -X end-of-line
sleep 0.125
tmux send-keys -X copy-selection-no-clear
tmux send-keys -X clear-selection
tmux send-keys -X jump-to-mark
