#!/bin/bash
source ./install/common.sh

if [ $(is_installed fzf) != "0" ]; then
    echo "Installing fzf"
    case $(os) in
        darwin*)
        brew install fzf
        $(brew --prefix)/opt/fzf/install
        ;;
        ubuntu*)
        sudo apt-get update
        sudo apt-get install fzf
        ;;
        *)
        echo "Currently not supported"
        ;;
    esac
fi