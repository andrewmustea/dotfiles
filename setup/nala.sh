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
readonly RED='\033[0;31m'
readonly WHT='\033[0;37m'

error-msg() {
  printf "%b: %b\n" "${RED}Error${WHT}" "$*" 1>&2
}

# check if user is root
if (( EUID != 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# get distro name
NAME="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"
readonly NAME

# check distro version
unset RELEASE LEGACY
if [[ "${NAME}" == "ubuntu" ]]; then
  RELEASE="$(grep "^VERSION_ID=" /etc/os-release |
             awk -F '[".]' '{ print $2 }')"
  if (( RELEASE < 20 )); then
    error-msg "nala requires Ubuntu release >=20.04"
    exit 1
  elif (( RELEASE < 22 )); then
    LEGACY=1
  fi
elif [[ "${NAME}" != "debian" ]]; then
  error-msg "nala requires a debian or debian-based distro"
  exit 1
fi
readonly RELEASE LEGACY

# check if root
if (( EUID != 0 )); then
  error-msg "Run script as root"
  exit 1
fi

# add source files
echo "deb https://deb.volian.org/volian/ scar main" |
  sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key |
  sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

# install nala
sudo apt update
if [[ -n "${LEGACY}" ]]; then
  echo "Installing nala-legacy..."
  sudo apt install -y nala-legacy
else
  echo "Installing nala..."
  sudo apt install -y nala
fi
exit "$?"

