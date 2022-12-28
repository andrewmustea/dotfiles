#!/bin/bash

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${DISTRO}" == "arch" ]]; then
    sudo pacman -S --needed --noconfirm ghc shellcheck
    exit 0
fi

if ! hash cabal &>/dev/null; then
    printf "Cabal not installed. Proceed to install? [Y/n] "
    read -r response
    case "${response}" in
        [yY] | [yY][eE][sS] | "")
            ;;
        [nN] | [nN][oO])
            echo "Not installing haskell."
            exit 0
            ;;

        *)
            echo "Unknown response: ${response}"
            echo "Not installing haskell."
            exit 1
            ;;
    esac

    [[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
    [[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
    [[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"
    [[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"

    export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
    export CABAL_DIR="${XDG_DATA_HOME}/cabal"
    export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
    export GHCUP_USE_XDG_DIRS=true
    export BOOTSTRAP_HASKELL_INSTALL_STACK=true
    export BOOTSTRAP_HASKELL_INSTALL_HLS=true
    export BOOTSTRAP_HASKELL_ADJUST_CABAL_CONFIG=true

    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

    local_bin="${HOME}/.local/bin"
    if [[ ":${PATH}:" != ":${local_bin}:" ]]; then
        export PATH="${local_bin}${PATH:+:${PATH}}"
    fi

    cabal_bin="${XDG_DATA_HOME}/cabal/bin"
    if [[ ":${PATH}:" != ":${cabal_bin}:" ]]; then
        export PATH="${cabal_bin}${PATH:+:${PATH}}"
    fi
fi

cabal install shellcheck

