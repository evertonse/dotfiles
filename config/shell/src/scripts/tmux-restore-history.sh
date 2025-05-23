#!/bin/sh

pane_id_prefix="resurrect_"
# Create history directory if it doesn't exist
HISTS_DIR="$HOME/.config/zsh/zsh-history"
mkdir -p "${HISTS_DIR}"

if [ -n "${TMUX_PANE}" ]; then
  # Check if we've already set this pane title
  pane_id=$(tmux display -pt "${TMUX_PANE}" "#{pane_title}")
  
  # Use case statement instead of [[ ]] for pattern matching
  case "$pane_id" in
    "$pane_id_prefix"*)
      # Already has prefix, nothing to do
      ;;
    *)
      # Generate a random ID using POSIX methods
      random_id=$(dd if=/dev/urandom bs=1 count=32 2>/dev/null | tr -dc A-Za-z0-9 | head -c 16)
      printf "\033]2;%s%s\033\\" "$pane_id_prefix" "$random_id"
      pane_id=$(tmux display -pt "${TMUX_PANE}" "#{pane_title}")
      ;;
  esac

  # Use the pane's random ID for the HISTFILE
  HISTFILE="${HISTS_DIR}/history_tmux_${pane_id}"
else
  HISTFILE="${HISTS_DIR}/history_no_tmux"
fi
export HISTFILE

# Stash the new history each time a command runs
# PROMPT_COMMAND is bash-specific, use trap for POSIX compliance
trap 'history -a' DEBUG
