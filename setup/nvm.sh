#!/bin/sh

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if which nvm >/dev/null 2>&1; then
    echo "nvm already installed"
    if which node >/dev/null 2>&1; then
        echo "node already installed"
        exit
    fi
elif [ "$DISTRO" = "arch" ]; then
    sudo pacman -S --needed --noconfirm nvm
    . /usr/share/nvm/init-nvm.sh
else
    [ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config

    export NVM_DIR="$XDG_CONFIG_HOME/nvm"

    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"

    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

nvm install node --default --latest-npm

npm install -g npm@latest neovim commitizen

