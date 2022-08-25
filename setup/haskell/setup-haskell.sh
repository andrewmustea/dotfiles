#!/bin/sh

# Setup haskell and haskell binaries

if ! which cabal >/dev/null 2>&1; then
    printf "Cabal not installed. Proceed to install? [Y/n] "
    read -r response
    case "$response" in
        [yY] | [yY][eE][sS] | "")
            ;;
        [nN] | [nN][oO])
            echo "Not installing haskell."
            exit
            ;;

        *)
            echo "Unknown response: $response"
            echo "Not installing haskell."
            exit
            ;;
    esac

    [ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
    [ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
    [ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
    [ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"

    export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
    export CABAL_DIR="$XDG_DATA_HOME"/cabal
    export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
    export GHCUP_USE_XDG_DIRS=true
    export BOOTSTRAP_HASKELL_INSTALL_STACK=true
    export BOOTSTRAP_HASKELL_INSTALL_HLS=true
    export BOOTSTRAP_HASKELL_ADJUST_CABAL_CONFIG=true

    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

    case ":$PATH:" in
        *:"$HOME/.local/bin":*)
            ;;
        *)
            export PATH="$HOME/.local/bin:$PATH"
            ;;
    esac
fi

cabal install ShellCheck

