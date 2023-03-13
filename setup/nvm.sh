#!/bin/bash

# check if nvm is installed
if declare -f -F nvm > /dev/null; then
  echo "nvm already installed"
  exit 0
fi

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# XDG directory
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"

# nvm directory
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# arch linux
if [[ "${NAME}" = "arch" ]]; then
  sudo pacman -S --needed --noconfirm nvm
  mkdir --parents "${NVM_DIR}"
  source /usr/share/nvm/init-nvm.sh
  exit 0
else
  git clone https://github.com/nvm-sh/nvm.git "${NVM_DIR}"

  # source files
  [[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"
  [[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"
fi

# install node and npm
nvm install node --default --latest-npm

# install packages
npm install -g neovim markdownlint

