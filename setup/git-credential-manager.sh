#!/bin/bash

#
# ./setup/git-credential-manager.sh
#

# install the git-credential-manager tool

# TODO: Ask to update if already installed

# check if git-credential-manager is installed
if hash git-credential-manager &>/dev/null; then
  echo "git-credential-manager is already installed"
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
  if hash paru &>/dev/null; then
    sudo paru -S --needed --noconfirm git-credential-manager-core-bin
  elif hash yay &>/dev/null; then
    sudo yay -S --needed --noconfirm git-credential-manager-core-bin
  else
    error-msg "installing git-credential-manager requires an AUR helper"
    exit 1
  fi

  exit "$?"
fi

# --------------------
# debian/ubuntu
# --------------------

if [[ "${NAME}" == "debian" ]] || [[ "${NAME}" == "ubuntu" ]]; then
  # check for github-cli
  if ! hash gh &>/dev/null && ! ./github-cli.sh; then
    error-msg "installing git-credential-manager requires github-cli"
    exit 1
  fi

  # use nala if available
  if hash nala &>/dev/null; then
    readonly PACKAGE_MANAGER=nala
  else
    readonly PACKAGE_MANAGER=apt
  fi

  # set variables
  ARCH="$(dpkg --print-architecture)"
  TEMP=/tmp/git-credential-manager
  PROJECT="git-ecosystem/git-credential-manager"
  PATTERN="gcm-linux_${ARCH}.*\.deb"
  readonly ARCH TEMP PROJECT PATTERN

  # create temporary directory
  rm -rf "${TEMP}"
  mkdir -p "${TEMP}"

  # download release package
  if ! gh release download --skip-existing -R "${PROJECT}" -p "${PATTERN}" -D "${TEMP}"; then
    rm -rf "${TEMP}"
    exit 1
  fi

  # install package
  PACKAGE="$(ls -d "${TEMP}")"
  readonly PACKAGE
  if ! dpkg -i "${PACKAGE}"; then
    error-msg "couldn't install package: ${PACKAGE}"
    exit 1
  fi

  # clean up /tmp/git-credential-manager
  rm -rf "${TEMP}"

  exit 0
fi

# --------------------
# other
# --------------------

error-msg "unsupported distribution: '${NAME}'"
exit 1

