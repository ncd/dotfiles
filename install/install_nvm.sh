#!/bin/bash
source ./install/common.sh

configure_node() {
    if [ $(is_installed npx) != "0" ]; then
        echo "Installing npx"
        npm install npx
    else
        echo "npx installed"
    fi
    if [ $(is_installed pnpm) != "0" ]; then
        sh -c "$(curl -fsSL https://get.pnpm.io/install.sh)" -s --batch || {
            echo "Could not install PNPM" >/dev/stderr
            exit 1
        }
    else
        echo "PNPM installed"
    fi
}

if [ ! -d "$HOME/.nvm" ]; then
    sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)" -s --batch || {
        echo "Could not install NVM" >/dev/stderr
        exit 1
    }
fi

if [ $(is_installed node) != "0" ]; then
    echo "Installing node"
    nvm install --lts
else
    echo "Node installed"
fi

if [ $(is_installed yarn) != "0" ]; then
    echo "Installing yarn"
    sh -c "$(curl -o- -L https://yarnpkg.com/install.sh)" -s --batch || {
        echo "Could not install Yarn" >/dev/stderr
        exit 1
    }
else
    echo "Yarn installed"
fi

configure_node

