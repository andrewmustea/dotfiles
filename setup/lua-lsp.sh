#!/bin/bash

if hash lua-language-server &>/dev/null; then
    echo "lua-language-server already installed"
    exit
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${DISTRO}" == "arch" ]]; then
    sudo pacman -S --needed --noconfirm lua-language-server
    exit 0
fi

if [[ "${DISTRO}" != "debian" ]] && [[ "${DISTRO}" != "ubuntu" ]]; then
    echo "distro not supported: ${DISTRO}"
    exit 1
fi

[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

if hash nala &>/devl/null; then
    sudo nala install -y ninja-build
else
    sudo apt install -y ninja-build
fi

lsp_dir="${XDG_DATA_HOME}/lua-language-server"

git clone --depth=1 https://github.com/sumneko/lua-language-server "${lsp_dir}"
git -C "${lsp_dir}" submodule update --depth 1 --init --recursive

cd "${lsp_dir}3rd/luamake" || exit 1
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

if [[ ":${PATH}:" != ":${lsp_dir}/bin:" ]]; then
    export PATH="${PATH:+${PATH}:}${lsp_dir}/bin"
fi

