#!/bin/bash
source ./install/common.sh

if [ $(is_installed ag) != "0" ]; then
    echo "Installing ag"
    case $(os) in
        darwin*)
        brew install the_silver_searcher
        ;;
        ubuntu*)
        sudo apt-get update
        sudo apt-get install silversearcher-ag
        ;;
        *)
        echo "Currently not supported"
        ;;
    esac
fi