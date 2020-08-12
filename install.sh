#!/bin/bash

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
  add_zsh_theme
}

add_zsh_theme() {
  echo "Installing powerlevel10k theme"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi
  cp styles/p10k.zsh $HOME/.p10k.zsh
  cp styles/dircolor $HOME/.dircolors
  echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> $HOME/.zshrc
  sed -i -E "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/" $HOME/.zshrc
}

configure_tmux() {
  echo "Installing tmux plugin manager"
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  fi
  cp tmux.conf $HOME/.tmux.conf
  tmux source $HOME/.tmux.conf

  echo "Install plugin"
  ./sh/tmux_plugin_install.sh
}

configure_vim() {
  echo "Installing vim plugin manager"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  cp vimrc $HOME/.vimrc
  cp vimrc.bundles $HOME/.vimrc.bundles
  vim +PlugInstall +qall
}

configure_zsh() {
  echo "Configure zsh"
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] ; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    sed -i -E "s/(plugins.*)\)/\1 zsh-autosuggestions)/" $HOME/.zshrc
  fi
  cp zshrc $HOME/.zshrc.local
  echo "source $HOME/.zshrc.local" >> $HOME/.zshrc
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
        sudo apt install vim
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
        sudo apt-get install silversearcher-ag
        ;;
      *)
        echo "Currently not supported"
        ;;
    esac
  fi
}

apps=(zsh tmux vim oh_my_zsh)

for app in "${apps[@]}"
do
  install_$app
done

configs=(tmux vim zsh)
for config in "${configs[@]}"
do
  configure_$config
done
