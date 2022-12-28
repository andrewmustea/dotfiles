#!/bin/bash

if hash fzf &>/dev/null; then
    echo "fzf already installed"
    exit 0
fi

distro="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${distro}" == "arch" ]]; then
    echo "Installing fzf using pacman..."
    sudo pacman -S --needed --noconfirm fzf
    exit 0
fi

if hash brew &>/dev/null; then
    echo "Installing fzf using homebrew..."
    brew install fzf
    exit 0
fi

echo "Installing fzf using git..."

[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

fzf_dir="${XDG_DATA_HOME}/fzf"
git clone https://github.com/junegunn/fzf.git "${fzf_dir}"
"${fzf_dir}/install" --xdg --bin

fzf_config="${XDG_CONFIG_HOME}/fzf/fzf.bash"
cp "$(cd -- "$(dirname -- "$0")" && pwd -P)/../fzf/git_fzf.bash" "${fzf_config}"
source "${fzf_config}"

