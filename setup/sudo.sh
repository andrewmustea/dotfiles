#!/bin/bash

#
# ./setup/sudo.sh
#

# install sudo v1.19 manually for ubuntu systems

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
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
  echo "sudo v1.9+ already installed"
  exit 0
fi

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# github-cli variables
TEMP="/tmp/sudo"
PROJECT="sudo-project/sudo"
RELEASE="$(lsb_release -r | awk -F ':\t' '{ gsub("\\.", "", $2); print $2 }')"
PATTERN="sudo_[0-9].*ubu${RELEASE}_$(dpkg --print-architecture)\.deb"
readonly TEMP PROJECT RELEASE PATTERN

# create temporary directory
rm -rf "${TEMP}"
mkdir "${TEMP}"

# download package
if ! gh release download --skip-existing -R "${PROJECT}" -p "${PATTERN}" -D "${TEMP}"; then
  rm -rf "${TEMP}"
  exit 1
fi

# install package
PACKAGE="${TEMP}/$(ls "${TEMP}")"
readonly PACKAGE
if ! sudo dpkg -i "${PACKAGE}"; then
  error-msg "couldn't install package: ${PACKAGE}"
  exit 1
fi

# clean up /tmp/sudo
rm -rf "${TEMP}"

