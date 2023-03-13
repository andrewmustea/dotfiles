#!/bin/bash

#
# ./setup/rust.sh
#

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# arch linux
if [[ "${NAME}" = "arch" ]]; then
  readonly PACKAGES="as-tree bat bottom cargo dust exa fd gitui git-delta \
                     git-gone hck hex ripgrep rm-improved rust sd \
                     tree-sitter-cli viu"
  if hash paru &>/dev/null; then
    sudo paru -S --needed --noconfirm "${PACKAGES}"
  elif hash yay &>/dev/null; then
    sudo yay -S --needed --noconfirm "${PACKAGES}"
  else
    error-msg "installing rust and rust packages requires an AUR helper"
    exit 1
  fi
  exit 0
fi

if [[ "${NAME}" == "debian" ]] || [[ "${NAME}" == "ubuntu" ]]; then
  if ! hash cargo &>/dev/null; then
    # XDG directory
    [[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

    # rust home directories
    export CARGO_HOME="${XDG_DATA_HOME}/cargo"
    export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

    # download and run install script
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

    # source rust environment
    source "${CARGO_HOME}/env"

    # add rustup bash completion
    readonly COMPLETIONS="${XDG_DATA_HOME}/bash-completion/completions"
    mkdir -p "${COMPLETIONS}"
    rustup completions bash > "${COMPLETIONS}/rustup"
  fi

  # install packages
  cargo install bat bottom cargo-fix cargo-update du-dust exa fd-find \
        git-delta git-gone gitui hck hx ripgrep rm-improved sd \
        tree-sitter-cli viu
  cargo install -f --git https://github.com/jez/as-tree

  # update packages
  cargo install-update --all

  # build bat bache
  bat cache --build

  exit 0
fi

# other
error-msg "unsupported distribution: '${NAME}'"
exit 1

