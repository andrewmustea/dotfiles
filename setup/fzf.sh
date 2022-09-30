#!/bin/sh

if which fzf >/dev/null 2>&1; then
    echo "fzf already installed"
    exit
fi

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [ "$DISTRO" = "arch" ]; then
    sudo pacman -S --needed --noconfirm fzf
    exit
elif [ "$DISTRO" = "debian" ]; then
    if which nala >/dev/null 2>&1; then
        sudo nala install -y fzf
    else
        sudo apt install -y fzf
    fi
    exit
elif [ "$DISTRO" != "ubuntu" ]; then
    echo "Distro not supported: $DISTRO"
    exit 1
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

