#!/bin/bash

source ./install/common.sh

configure_vim() {
  echo "Installing vim plugin manager"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  cp vim/vimrc $HOME/.vimrc
  cp vim/vimrc.bundles $HOME/.vimrc.bundles
  vim +PlugInstall +qall
}

if [ $(is_installed vim) != "0" ]; then
    echo "Installing vim"
    case $(os) in
        darwin*)
        brew install vim
        ;;
        ubuntu*)
        sudo apt-get install vim
        ;;
        *)
        echo "Currently not supported"
        ;;
    esac
fi
configure_vim
