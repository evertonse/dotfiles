# ~/.zsh/tmux_resurrect_history.zsh

# IMPORTANT: This file MUST be include after vars.sh

pane_id_prefix="resurrect_"
HISTS_DIR="$HOME/.zsh_history.d"
mkdir -p "${HISTS_DIR}"

if [[ -n "$TMUX_PANE" ]]; then
  # Get current pane title
  pane_id=$(tmux display -pt "$TMUX_PANE" "#{pane_title}")

  if [[ "$pane_id" != "$pane_id_prefix"* ]]; then
    # Set random pane ID as title
    random_id=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
    print -n "\033]2;${pane_id_prefix}${random_id}\033\\"
    pane_id=$(tmux display -pt "$TMUX_PANE" "#{pane_title}")
  fi

  export HISTFILE="${HISTS_DIR}/zsh_history_tmux_${pane_id}"
else
  export HISTFILE="${HISTS_DIR}/zsh_history_no_tmux"
fi

# Save history after each command
autoload -Uz add-zsh-hook
add-zsh-hook precmd history -a

