# Autosuggestion highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"

# Language enable
export LANG=en_US.UTF-8

# Set editor
export EDITOR='vim'
alias vi="vim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf apply
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux stuff
alias detach="tmux detach"
fo() {
  local file
  file=$(fzf-tmux -d 15 +m) &&
  vim $(echo "$file" | sed "s/.* //")
}

attach() {
  if [ -z "$1" ]; then
    tmux attach
  else
    tmux attach -t$1
  fi
}

news() {
  if [ -z "$1" ]; then
    tmux new
  else
    tmux new -s $1
  fi
}
