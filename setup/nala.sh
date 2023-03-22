#!/bin/bash

#
# ./setup/nala.sh
#

# install the debian apt front end nala

# check if nala is installed
if hash nala &>/dev/null; then
  echo "nala is already installed"
  exit 0
fi

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# get distro name
NAME="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"
ID_LIKE="$(grep "^ID_LIKE=" /etc/os-release | awk -F "=" '{ print $2 }')"
readonly NAME ID_LIKE

# check if system is debian or debian-based
if [[ "${NAME}" != "debian" ]] && [[ "${ID_LIKE}" != "debian" ]]; then
  error-msg "nala requires a debian or debian-based distro"
  exit 1
fi

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# determine nala version to install
NALA_VER="nala"
if [[ "${NAME}" == "ubuntu" ]]; then
  RELEASE="$(grep "^VERSION_ID=" /etc/os-release | awk -F '[".]' '{ print $2 }')"
  readonly RELEASE
  if (( RELEASE < 20 )); then
    error-msg "nala requires ubuntu 20.04+"
    exit 1
  elif (( RELEASE < 22 )); then
    NALA_VER="nala-legacy"
  fi
fi
readonly NALA_VER

# download apt keyring
readonly SOURCE="https://deb.volian.org/volian/scar.key"
readonly KEYRING="/etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg"
if ! wget -qO - "${SOURCE}" | sudo tee "${KEYRING}" > /dev/null; then
  error-msg "couldn't download nala apt keyring"
  exit 1
fi

# add apt source list
readonly REPO="https://deb.volian.org/volian/"
readonly LIST="/etc/apt/sources.list.d/volian-archive-scar-unstable.list"
echo "deb ${REPO} scar main" | sudo tee "${LIST}" > /dev/null

# install nala
sudo apt update && sudo apt install -y "${NALA_VER}"

exit "$?"

