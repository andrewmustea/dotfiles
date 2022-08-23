#!/bin/sh

# Setup rust and rust binaries

if ! which cargo /dev/null 2>&1; then
    read -rp "Cargo not installed. Proceed to install? [Y/n] " response
    case "$response" in
        [yY] | [yY][eE][sS] | "")
            ;;
        [nN] | [nN][oO])
            echo "Not installing rust."
            exit
            ;;

        *)
            echo "Unknown response: $response"
            echo "Not installing rust."
            exit
            ;;
    esac

    [ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
    [ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
    [ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
    [ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- --no-modify-path -y

    mkdir --parents ~/.local/share/bash-completion/completions
    rustup completions bash > ~/.local/share/bash-completion/completions/rustup
fi

cargo install \
    bat bottom cargo-fix cargo-update du-dust exa fd-find git-delta gitui \
    hck hx ripgrep rm-improved sd viu
cargo install -f --git https://github.com/jez/as-tree

cargo install-update --all

