#!/bin/bash
cd "$(dirname "$0")"
DOTFILES=$(pwd)

is_installed() {
  type $1 >/dev/null 2>&1
  echo $?
}

os() {
  if [[ "$OSTYPE" == *"darwin"* ]]; then
    echo "darwin"
  elif [[ "$OSTYPE" == *"linux"* ]]; then
    os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    echo "${os,,}"
  else
    echo "Undetected"
  fi
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
      echo "Could not install Oh My Zsh" >/dev/stderr
      exit 1
    }
  else
    /bin/zsh $ZSH/tools/upgrade.sh
  fi
}

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
    git clone --depth 1 https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
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
  cp zshrc.zsh $HOME/.zshrc
  mk_rc
}

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

configure_vim() {
  echo "Installing vim plugin manager"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  cp vim/vimrc $HOME/.vimrc
  cp vim/vimrc.bundles $HOME/.vimrc.bundles
  vim +PlugInstall +qall
}

install_zsh() {
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
}

install_tmux() {
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
}

install_vim() {
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
}

install_fzf() {
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
}

install_ag() {
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
}

install_kubectl() {
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
}

merge_shrc() {
	printf '%s\n' *.sh *."$1" *."$1".in *."$1.$(uname -s)" |
	sort |
	while read f; do
		case "$f" in
		"*."*)	;;
		*.in)	sed "s,[$]DOTFILES,$DOTFILES," "$f" ;;
		*)	cat "$f" ;;
		esac
	done
}

mk_rc() {
	cd zsh
	if command -v bash >/dev/null 2>&1; then
		merge_shrc bash >>"$HOME/.bashrc"
	fi
	if command -v zsh >/dev/null 2>&1; then
		merge_shrc zsh >>"$HOME/.zshrc"
		zsh -c "zcompile $HOME/.zshrc"
	fi
	cd ..
}

apps=(zsh tmux vim fzf oh_my_zsh ag kubectl)

for app in "${apps[@]}"
do
  install_$app
done

configs=(tmux vim zsh)
for config in "${configs[@]}"
do
  configure_$config
done

cp p10k.zsh $HOME/.p10k.zsh
cp dircolor $HOME/.dircolors

# $HOME/.zshrc
