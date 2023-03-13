#!/bin/bash

#
# ./setup/azure-cli.sh
#

# install the azure-cli tool

# check if azure-cli is installed
if hash az &>/dev/null; then
  echo "azure-cli already installed"
  exit 0
fi

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

# --------------------
# arch linux
# --------------------

if [[ "${NAME}" = "arch" ]]; then
  if hash paru &>/dev/null; then
    sudo paru -S --needed --noconfirm azure-cli
  elif hash yay &>/dev/null; then
    sudo yay -S --needed --noconfirm azure-cli
  else
    error-msg "installing azure-cli requires an AUR helper"
    exit 1
  fi

  exit "$?"
fi

# --------------------
# debian/ubuntu
# --------------------

if [[ "${NAME}" == "debian" ]] || [[ "${NAME}" == "ubuntu" ]]; then
  # use nala if available
  if hash nala &>/dev/null; then
    readonly PACKAGE_MANAGER="nala"
  else
    readonly PACKAGE_MANAGER="apt"
  fi

  # install required packages
  sudo "${PACKAGE_MANAGER}" update
  sudo "${PACKAGE_MANAGER}" install -y apt-transport-https ca-certificates \
                                       curl gnupg lsb-release

  # apt key variables
  SOURCE="https://packages.microsoft.com/keys/microsoft.asc"
  TEMP="/tmp/microsoft"
  ASC="${TEMP}/microsoft.asc"
  KEY="/etc/apt/trusted.gpg.d/microsoft.gpg"
  readonly SOURCE TEMP ASC KEY

  # create temporary directory
  rm -rf "${TEMP}"
  mkdir "${TEMP}"

  # download asc key file
  if ! curl -fsSL --create-dirs "${SOURCE}" -o "${ASC}"; then
    error-msg "couldn't download azure-cli apt key"
    rm -rf "${TEMP}"
    exit 1
  fi

  # dearmor key
  if ! sudo gpg -o "${KEY}" --dearmor "${ASC}"; then
    error-msg "couldn't dearmor azure-cli asc file: ${ASC}"
    exit 1
  fi

  # delete temporary directory
  rm -rf "${TEMP}"

  # add read permissions to key for group and owner
  sudo chmod go+r "${KEY}"

  # azure-cli source list variables
  ARCH="$(dpkg --print-architecture)"
  CODENAME="$(lsb_release -cs)"
  REPO="https://packages.microsoft.com/repos/azure-cli/"
  LIST="/etc/apt/sources.list.d/azure-cli.list"
  readonly ARCH CODENAME REPO LIST

  # add azure-cli to apt source list
  echo "deb [arch=${ARCH} signed-by=${KEY}] ${REPO} ${CODENAME} main" | sudo tee "${LIST}"

  # update apt package info and install azure-cli
  sudo "${PACKAGE_MANAGER}" update && sudo "${PACKAGE_MANAGER}" install -y azure-cli

  exit "$?"
fi

# --------------------
# other
# --------------------

error-msg "unsupported distribution: '${NAME}'"
exit 1

