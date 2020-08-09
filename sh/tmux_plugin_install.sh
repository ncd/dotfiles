#!/bin/bash

if tmux info &> /dev/null; then
  # Install plugins
  $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
else
  # Start tmux server but don't attach to it
  tmux start-server
  # Start new session but don't attach to it either
  tmux new-session -d
  # Install plugins
  $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
  # Kill tmux server
  tmux kill-server
fi
