#!/bin/bash

#
# ./setup/fzf.sh
#

# install the fzf fuzzy finder tool

# check if fzf is installed
if hash fzf &>/dev/null; then
  echo "fzf already installed"
  exit 0
fi

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# pacman install
if [[ "${NAME}" == "arch" ]]; then
  sudo pacman -S --needed --noconfirm fzf
  exit "$?"
fi

# homebrew install
if hash brew &>/dev/null; then
  brew install fzf
  exit "$?"
fi

# XDG directories
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# git install
FZF_DIR="${XDG_DATA_HOME}/fzf"
git clone https://github.com/junegunn/fzf.git "${FZF_DIR}"
"${FZF_DIR}/install" --xdg --bin

