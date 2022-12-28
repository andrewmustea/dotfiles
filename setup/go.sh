#!/bin/bash

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${DISTRO}" == "arch" ]]; then
    sudo pacman -S --needed --noconfirm \
        golang shfmt golines glow lemonade gofumpt goimports
    exit
fi

if ! [[ -d /usr/local/go ]]; then
    wget -cq --show-progress https://go.dev/dl/go1.19.linux-amd64.tar.gz -P /tmp && \
        sudo rm -rf /usr/local/go && \
        sudo tar -C /usr/local -xzf /tmp/go1.19.linux-amd64.tar.gz && \
        rm /tmp/go1.19.linux-amd64.tar.gz

    if [[ ":${PATH}:" != ":/usr/local/go/bin:" ]]; then
        export PATH="${PATH:+${PATH}:}/usr/local/go/bin"
    fi
fi

[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

export GOPATH="${DATA}/go"

go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/segmentio/golines@latest
go install github.com/charmbracelet/glow@latest
go install github.com/lemonade-command/lemonade@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest

