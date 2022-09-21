#!/bin/bash
source ./install/common.sh
if [ $(is_installed kubectl) != "0" ]; then
    echo "Installing kubectl"
    case $(os) in
      darwin*)
        brew install kubectl
        ;;
      ubuntu*)
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl
        sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo apt-get update
        sudo apt-get install -y kubectl
        ;;
      *)
        echo "Currently not supported"
        ;;
    esac
fi