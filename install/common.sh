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