#!/bin/sh

#
# /etc/profile.d/arch.sh
#

if which paru >/dev/null 2>&1; then
    export PACKAGE_MANAGER="paru"
elif which yay >/dev/null 2>&1; then
    export PACKAGE_MANAGER="yay"
else
    echo "No AUR helper detected. Using pacman as the package manager."
    export PACKAGE_MANAGER="pacman"
fi

alias pac='"$PACKAGE_MANAGER"'
alias pacsearch='"$PACKAGE_MANAGER" -Ss'
alias pacquery='"$PACKAGE_MANAGER" -Q'

# fzf
[ -f "$CONFIG/fzf/fzf.bash" ] && . "$CONFIG/fzf/fzf.bash"

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -d "$NVM_DIR" ] && . "$NVM_DIR/nvm.sh"

