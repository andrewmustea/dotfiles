#!/bin/sh

# list of rust binaries to install

if which cargo /dev/null 2>&1; then
    echo "cargo not installed"
    # TODO install cargo if not available
    exit
fi

cargo install bat cargo-update fd-find exa git-delta ripgrep viu
cargo install -f --git https://github.com/jez/as-tree

cargo install-update --all

