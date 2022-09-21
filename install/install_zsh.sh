#!/bin/bash
source ./install/common.sh

add_zsh_theme() {
  echo "Installing powerlevel10k theme"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi
}

# https://github.com/jeffreytse/zsh-vi-mode
add_zsh_vi_mode() {
  echo "Installing zsh-vi-mode"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode" ]; then
    git clone --depth 1 https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode
  fi
}

add_fast_syntax_highlighting() {
  echo "Installing fast-syntax-highlighting"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]; then
    git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  fi
}

add_fzf_tab() {
  echo "Installing fzf-tab"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab" ]; then
    git clone --depth 1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
  fi
}

add_z() {
  echo "Installing z"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z" ]; then
    git clone --depth 1 https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
  fi
}

add_fz() {
  echo "Installing fz"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fz" ]; then
    git clone --depth 1 https://github.com/changyuheng/fz.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fz
  fi
}

add_zsh_autosuggestions() {
  echo "Installing zsh-autosuggestions"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi
}

configure_zsh() {
  echo "Configuring zsh"
  add_zsh_theme
  add_fzf_tab
  add_zsh_autosuggestions
  add_fast_syntax_highlighting
  add_zsh_vi_mode
  add_z
  add_fz
}

if [ $(is_installed zsh) != "0" ]; then
    echo "Installing zsh"
    case $(os) in
        darwin*)
        brew install zsh
        ;;
        ubuntu*)
        sudo apt install zsh
        ;;
        *)
        echo "Currently not supported"
        ;;
    esac
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
        echo "Could not install Oh My Zsh" >/dev/stderr
        exit 1
    }
else
    /bin/zsh $ZSH/tools/upgrade.sh
fi

configure_zsh
