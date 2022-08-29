#!/bin/sh

# Install and setup fzf

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"
if [ "$DISTRO" = "arch" ]; then
    echo "Use pacman to install fzf."
    exit
fi

if ! which fzf >/dev/null 2>&1; then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git "$XDG_DATA_HOME/fzf"
    "$XDG_DATA_HOME/fzf/install" --xdg --bin
    mkdir --parents "$XDG_CONFIG_HOME/fzf"
    cp -rf "$(cd -- "$(dirname -- "$0")" && pwd -P)/../fzf/" "$XDG_CONFIG_HOME"
else
    echo "Updating fzf..."
    git -C "$XDG_DATA_HOME/fzf" pull
    "$XDG_DATA_HOME/fzf/install --xdg --bin"
fi

