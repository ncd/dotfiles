#!/bin/bash

is_installed() {
  type $1 >/dev/null 2>&1
  echo $?
}

install_oh_my_zsh() {
  if [ -z "$ZSH" ]; then
    curl -Lo install_omz.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    ./install_omz.sh
  else
    sh $ZSH/tools/upgrade.sh
  fi
}

configure_theme() {
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

install_zsh() {
  if [ $(is_installed zsh) != "0" ]; then
    echo "Installing zsh"
    case "$OSTYPE" in
      darwin*)
        brew install zsh
        ;;
      linux*)
        sudo apt install zsh
        ;;
      *)
        echo "Currently not supported"
        ;;
    esac
  fi
}

install_tmux() {
  if [ $(is_installed tmux) != "0" ]; then
    echo "Installing tmux"
    case "$OSTYPE" in
      darwin*)
        brew install tmux
        ;;
      linux*)
        sudo apt install tmux
        ;;
      *)
        echo "Currently not supported"
        ;;
    esac
  fi   
}

install_vim() {
  if [ $(is_installed vim) != "0" ]; then
    echo "Installing vim"
    case "$OSTYPE" in
      darwin*)
        brew install vim
        ;;
      linux*)
        sudo apt install vim
        ;;
      *)
        echo "Currently ot supported";
        ;;
    esac
  fi
}

apps=(zsh tmux vim oh_my_zsh)

for app in "${apps[@]}"
do
  install_$app
done
configs=(theme)
for config in "${configs[@]}"
do
  configure_$config
done
