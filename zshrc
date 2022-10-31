# eval "$(dircolors $HOME/.dircolors)"

# Autosuggestion highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"

# Language enable
export LANG=en_US.UTF-8

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kubectl
  zsh-z
  )

# OMZ Disable update check
DISABLE_UPDATE_PROMPT=true

source $ZSH/oh-my-zsh.sh

# User configuration
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set editor
export EDITOR='vim'
alias vi="vim"
alias src="source $HOME/.zshrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# fzf apply
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load local config
[ -f ~/.local_cfg ] &&  source ~/.local_cfg

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
