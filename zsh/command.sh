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
