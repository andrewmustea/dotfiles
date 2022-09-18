#!/bin/sh
# compare repository configs against user configs


# XDG
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config


# bat
git submodule update --init --recursive

if ! [ -d ~/.config/bat ]; then
    cp -rf bat/ ~/.config/

    # maybe check if bat cache --build is done?
    which bat > /dev/null 2>&1 && bat cache --build
fi

diff -qr bat/ ~/.config/bat/ && cp -rf bat "$XDG_DATA_HOME"


# bash
# TODO: ask to check if you want to ignore, view diff, or just copy
diff home/bashrc ~/.bashrc
diff home/bash_profile ~/.bash_profile
diff home/bash_logout ~/.bash_logout
diff etc/bash.bashrc /etc/bash.bashrc


# fzf
FZF_TARGET="${XDG_CONFIG_HOME:-$HOME/.config}"
if [ -d "$FZF_TARGET" ]; then
    git -C "$FZF_TARGET" checkout master
    git -C "$FZF_TARGET" pull
else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_TARGET"
fi

$FZF_TARGET/install --xdg --key-bindings --completion --no-update-rc

cp fzf/fzf.bash "$FZF_TARGET/fzf.bash"


# git
# TODO: change to check if each of git configs lines exist in XDG_CONFIG_HOME
diff git/config "$XDG_CONFIG_HOME/git/config"


# gtk
[ ! -d "$XDG_CONFIG_HOME/gtk-3.0" ] && cp -rf gtk-3.0 "$XDG_CONFIG_HOME"


# npm
diff npm "$XDG_CONFIG_HOME/npm" && cp -rf npm "$XDG_CONFIG_HOME"


# nvim
diff nvim "$XDG_CONFIG_HOME/nvim"
# TODO: ask to copy
# TODO: get list of ALE linters and check if installed


# profile
diff profile /etc/profile
[ -f ~/.profile ] && diff profile/home_profile ~/.profile

