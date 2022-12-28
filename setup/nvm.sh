#!/bin/bash

if declare -f -F nvm > /dev/null; then
    echo "nvm already installed"
    exit 0
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

if [[ "$DISTRO" = "arch" ]]; then
    sudo pacman -S --needed --noconfirm nvm
    mkdir --parents "${NVM_DIR}"
    source /usr/share/nvm/init-nvm.sh
    exit 0
fi

git clone https://github.com/nvm-sh/nvm.git "${NVM_DIR}"

[[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"
[[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

nvm install node --default --latest-npm

npm install -g npm@latest neovim commitizen markdownlint

