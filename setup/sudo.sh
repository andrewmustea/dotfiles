#!/bin/bash

#
# ./setup/sudo.sh
#

# install sudo v1.19 manually for ubuntu systems

# error message
readonly RED='\033[0;31m'
readonly WHT='\033[0;37m'

error-msg() {
  printf "%b: %b\n" "${RED}Error${WHT}" "$*" 1>&2
}

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# check if ubuntu
if [[ "${NAME}" != "ubuntu" ]]; then
  error-msg "current system is not Ubuntu"
  exit 1
fi

# check current sudo version
VERSION="$(sudo --version | awk -F'[ .]' 'NR==1{ print $4 }')"
readonly VERSION
if (( VERSION >= 9 )); then
  echo "sudo v1.9 already installed"
  exit 0
fi

# check if user is root
if (( EUID != 0 )); then
  error-msg "run script as root"
  exit 1
fi

# package manager
if hash nala &>/dev/null; then
  PACKAGE_MANAGER=nala
else
  PACKAGE_MANAGER=apt
fi
readonly PACKAGE_MANAGER

# set variables
ARCH="$(dpkg --print-architecture)"
DIR=/tmp/sudo
PROJECT="sudo-project/sudo"
RELEASE="$(lsb_release -r | awk -F ':\t' '{ gsub("\\.", "", $2); print $2 }')"
PATTERN="sudo_[0-9].*ubu${RELEASE}_${ARCH}\.deb"
readonly ARCH DIR PROJECT RELEASE PATTERN

# download package
rm -rf "${DIR}" && mkdir -p "${DIR}"
if ! gh release download --skip-existing -R "${PROJECT}" -p "${PATTERN}" -D "${DIR}"; then
  rm -rf "${DIR}"
  exit 1
fi

# install package
"${PACKAGE_MANAGER}" install "${DIR}"/*

# clean up /tmp/sudo
rm -rf "${DIR}"

