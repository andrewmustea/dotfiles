#!/bin/bash

#
# /etc/profile.d/ubuntu.sh
#

# golang
export GO_BIN=/usr/local/go/bin
if [[ -d "$GO_BIN" ]]; then
    case ":$PATH:" in
        *:"$GO_BIN":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$GO_BIN"
    esac
fi

# fzf
export FZF_DIR="$DATA/fzf"
export FZF_ENV="$CONFIG/fzf/fzf.bash"
[[ -f "$FZF_ENV" ]] && [[ -x "$FZF_DIR/bin/fzf" ]] && source "$FZF_ENV"

update-fzf() {
    if ! [[ -d $FZF_DIR ]]; then
        echo "Couldn't find fzf directory in '$FZF_DIR'"
        return 1
    fi
    git -C "$FZF_DIR" pull
    "$FZF_DIR/install --xdg --bin"
}

# nala
which nala &>/dev/null && alias apt='nala'

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
if [[ -d "$NVM_DIR" ]]; then
    source "$NVM_DIR/nvm.sh"
    source "$NVM_DIR/bash_completion"
fi

# Set PATH, MANPATH, etc., for Homebrew
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

