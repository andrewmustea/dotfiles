#!/bin/sh

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [ "$DISTRO" = "arch" ]; then
    rust_programs="as-tree bat bottom cargo dust exa fd git-delta \
        gitui hck hex ripgrep rm-improved rust sd viu"
    if which paru >/dev/null 2>&1; then
        sudo paru -S --needed --noconfirm "$rust_programs"
    elif which yay >/dev/null 2>&1; then
        sudo yay -S --needed --noconfirm "$rust_programs"
    else
        echo "No AUR helper detected. Can't install rust and rust programs"
        exit 1
    fi
    exit
elif [ "$DISTRO" != "debian" ] && [ "$DISTRO" != "ubuntu" ]; then
    echo "Distro not supported: $DISTRO"
    exit 1
fi

if ! which cargo >/dev/null 2>&1; then
    printf "Cargo not found. Proceed to install rustup and cargo? [Y/n] "
    read -r response
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

    export CARGO_HOME="$XDG_DATA_HOME/cargo"
    export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- --no-modify-path -y

    # source rust environment
    . "$XDG_DATA_HOME/cargo/env"

    # add rustup bash-completiona
    mkdir --parents ~/.local/share/bash-completion/completions
    rustup completions bash > ~/.local/share/bash-completion/completions/rustup
fi

cargo install \
    bat bottom cargo-fix cargo-update du-dust exa fd-find git-delta gitui \
    hck hx ripgrep rm-improved sd viu
cargo install -f --git https://github.com/jez/as-tree

cargo install-update --all

# build bat bache
bat cache --build

