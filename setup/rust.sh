#!/bin/bash

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${DISTRO}" = "arch" ]]; then
    rust_programs="as-tree bat bottom cargo dust exa fd gitui git-delta \
                   git-gone hck hex ripgrep rm-improved rust sd \
                   tree-sitter-cli viu"
    if hash paru &>/dev/null; then
        sudo paru -S --needed --noconfirm "${rust_programs}"
    elif hash yay &>/dev/null; then
        sudo yay -S --needed --noconfirm "${rust_programs}"
    else
        echo "No AUR helper detected. Can't install rust and rust programs."
        exit 1
    fi
    exit 0
fi

if [[ "${DISTRO}" != "debian" ]] && [[ "${DISTRO}" != "ubuntu" ]]; then
    echo "Distro not supported: ${DISTRO}"
    exit 1
fi


if ! hash cargo &>/dev/null; then
    printf "Cargo not found. Proceed to install rustup and cargo? [Y/n] "
    read -r response
    case "${response}" in
        [yY] | [yY][eE][sS] | "")
            ;;
        [nN] | [nN][oO])
            echo "Not installing rust."
            exit 0
            ;;
        *)
            echo "Unknown response: ${response}"
            echo "Not installing rust."
            exit 1
            ;;
    esac

    [[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

    export CARGO_HOME="${XDG_DATA_HOME}/cargo"
    export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- --no-modify-path -y

    # source rust environment
    source "${CARGO_HOME}/env"

    # add rustup bash-completiona
    mkdir --parents ~/.local/share/bash-completion/completions
    rustup completions bash > ~/.local/share/bash-completion/completions/rustup
fi

cargo install \
    bat bottom cargo-fix cargo-update du-dust exa fd-find git-delta \
    git-gone gitui hck hx ripgrep rm-improved sd tree-sitter-cli viu
cargo install -f --git https://github.com/jez/as-tree

cargo install-update --all

# build bat bache
bat cache --build

