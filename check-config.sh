#!/bin/sh
# compare repository configs against user configs


# XDG
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config
DATA=$XDG_DATA_HOME
CONFIG=$XDG_CONFIG_HOME


# bat
git submodule update --init --recursive

if ! [ -d ~/.config/bat ]; then
    cp -rf bat/ ~/.config/

    # maybe check if bat cache --build is done?
    which bat > /dev/null 2>&1 && bat cache --build
fi

diff -qr bat/ ~/.config/bat/ && cp -rf bat "$DATA"


# bash
# TODO: ask to check if you want to ignore, view diff, or just copy
diff home/bashrc ~/.bashrc
diff home/bash_profile ~/.bash_profile
diff home/bash_logout ~/.bash_logout
diff etc/bash.bashrc /etc/bash.bashrc


# fzf
FZF_TARGET="${CONFIG:-$HOME/.config}"
if [ -d "$FZF_TARGET" ]; then
    git -C "$FZF_TARGET" checkout master
    git -C "$FZF_TARGET" pull
else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_TARGET"
fi

$FZF_TARGET/install --xdg --key-bindings --completion --no-update-rc

cp fzf/fzf.bash "$FZF_TARGET/fzf.bash"


# git
# TODO: change to check if each of git configs lines exist in CONFIG
diff git/config "$CONFIG/git/config"


# gtk
gtkfile="$CONFIG/gtk-3.0/settings.ini"
if [ ! -f "$gtkfile" ]; then
    cp -rf gtk-3.0 "$CONFIG"
elif grep -F -x -v -f "$gtkfile" gtk-3.0/settings.ini; then
    awk FNR!=1 gtk-3.0/settings.ini >> "$gtkfile"
fi


# npm
diff npm "$CONFIG/npm" && cp -rf npm "$CONFIG"


# nvim
diff nvim "$CONFIG/nvim"
# TODO: ask to copy
# TODO: get list of ALE linters and check if installed


# profile
diff profile /etc/profile
[ -f ~/.profile ] && diff profile/home_profile ~/.profile

