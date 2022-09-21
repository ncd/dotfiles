#!/bin/bash
source ./install/common.sh

configure_tmux() {
  echo "Installing tmux plugin manager"
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  fi
  cp tmux/tmux.conf $HOME/.tmux.conf
  tmux source $HOME/.tmux.conf

  echo "Install plugin"
  ./tmux/tmux_plugin_install.sh
}

if [ $(is_installed tmux) != "0" ]; then
    echo "Installing tmux"
    case $(os) in
        darwin*)
        brew install tmux
        ;;
        ubuntu*)
        sudo apt install tmux
        ;;
        *)
        echo "Currently not supported"
        ;;
    esac
fi
configure_tmux