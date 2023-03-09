#!/bin/bash

#
# ./setup/github-cli.sh
#

# install the github-cli tool

# check if github-cli is installed
if hash gh &>/dev/null; then
  echo "github-cli is already installed"
  exit 0
fi

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# check if user is root
if (( EUID != 0 )); then
  error-msg "run script as root"
  exit 1
fi

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# --------------------
# arch linux
# --------------------

if [[ "${NAME}" == "arch" ]]; then
  pacman -S --noconfirm --needed github-cli
  exit "$?"
fi

# --------------------
# debian/ubuntu
# --------------------

if [[ "${NAME}" == "debian" ]] || [[ "${NAME}" == "ubuntu" ]]; then
  SOURCE="https://cli.github.com/packages/githubcli-archive-keyring.gpg"
  KEYRING="/usr/share/keyrings/githubcli-archive-keyring.gpg"
  ARCH="$(dpkg --print-architecture)"
  LIST="/etc/apt/sources.list.d/github-cli.list"
  REPO="https://cli.github.com/packages"
  readonly SOURCE KEYRING ARCH LIST REPO

  # download key
  if ! curl -fsSL --create-dirs "${SOURCE}" -o "${KEYRING}"; then
    error-msg "couldn't download github-cli apt keyring"
    exit 1
  fi

  # add read permissions to keyring for group and owner
  chmod go+r "${KEYRING}"

  # add github-cli to apt source list
  echo "deb [arch=${ARCH} signed-by=${KEYRING}] ${REPO} stable main" | tee "${LIST}"

  # update apt package info and install github-cli
  if hash nala &>/dev/null; then
    nala update && nala install -y gh
  else
    apt update && apt install -y gh
  fi

  exit "$?"
fi

# --------------------
# other
# --------------------

error-msg "unsupported distribution: '${NAME}'"
exit 1

