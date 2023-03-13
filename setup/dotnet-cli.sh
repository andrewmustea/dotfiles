#!/bin/bash

#
# ./setup/dotnet-cli.sh
#

# install the dotnet-cli tool locally

# check if dotnet-cli is installed
# TODO: uninstall if global, then reinstall locally
if hash dotnet &>/dev/null; then
  echo "dotnet-cli already installed"
  exit 0
fi

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# check if user is root
if (( EUID != 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# XDG data directory
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# create temp directory
readonly TEMP="/tmp/dotnet-cli"
rm -rf "${TEMP}"
mkdir "${TEMP}"

# download install script
readonly SOURCE="https://dot.net/v1/dotnet-install.sh"
readonly FILE="${TEMP}/dotnet-install.sh"
if ! wget "${SOURCE}" -O "${FILE}"; then
  error-msg "couldn't download installer script"
fi

# set dotnet install directory
readonly DOTNET_INSTALL_DIR="${XDG_DATA_HOME}/dotnet"

# install dotnet
"${FILE} --install-dir ${DOTNET_INSTALL_DIR}"

# set dotnet root directory
export DOTNET_ROOT="${XDG_DATA_HOME}/dotnet"
if [[ ":${PATH}:" != *":${DOTNET_ROOT}:"* ]]; then
  export PATH="${DOTNET_ROOT}${PATH:+":${PATH}"}"
fi

# set dotnet tools directory
export DOTNET_TOOLS="${DOTNET_ROOT}/tools"
if [[ ":${PATH}:" != *":${DOTNET_TOOLS}:"* ]]; then
  export PATH="${DOTNET_TOOLS}${PATH:+":${PATH}"}"
fi

# remove dotnet home directory
rm -rf "${HOME}/.dotnet"

# clean up temp directory
rm -rf "${TEMP}"

