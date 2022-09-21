#!/bin/bash
cd "$(dirname "$0")"
DOTFILES=$(pwd)

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

for app in $(find install -type f -name "install_*.sh")
do
  echo $app
  ./$app
done

cp zshrc.zsh $HOME/.zshrc
mk_rc
cp p10k.zsh $HOME/.p10k.zsh
cp dircolor $HOME/.dircolors

# $HOME/.zshrc
