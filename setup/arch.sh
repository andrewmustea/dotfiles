#!/bin/bash

#
# ./setup/arch.sh
#

# setup a new arch linux system

# --------------------------------------------------
# utils
# --------------------------------------------------

readonly RED='\033[0;31m'
# readonly GRN='\033[0;32m'
readonly YLW='\033[0;33m'
# readonly BLU='\033[0;34m'
# readonly PPL='\033[0;35m'
# readonly CYN='\033[0;36m'
readonly WHT='\033[0;37m'

warn-msg() {
  printf "%b: %b\n" "${YLW}Error${WHT}:" "$*" 1>&2
}

error-msg() {
  printf "%b: %b\n" "${RED}Error${WHT}:" "$*" 1>&2
}

alias install='"${PACKAGE_MANAGER}" -S --noconfirm --needed'

# --------------------------------------------------
# environment
# --------------------------------------------------

# get distro name
NAME="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"
readonly NAME

# check if system is arch
if [[ "${NAME}" != "arch" ]]; then
  error-msg "Current system is not Arch"
  exit 1
fi

# check if user is root
if (( EUID != 0 )); then
  error-msg "Run script as root"
  exit 1
fi

# check for package manager
PACKAGE_MANAGER=pacman
if hash paru &>/dev/null; then
  PACKAGE_MANAGER=paru
elif hash yay &>/dev/null; then
  PACKAGE_MANAGER=yay
else
  warn-msg "Couldn't find an AUR package manager. Using 'pacman' instead"
fi
readonly PACKAGE_MANAGER

# --------------------------------------------------
# packages
# --------------------------------------------------

install \
  autoconf automake bash-completion binutils bison chrpath clang clang-format \
  clang-tools clangd cmake cmatrix cmatrix-xfont command-not-found cpio curl \
  diffstat doxygen flex g++ gawk gcc gdb gem gettext git gpg ipgutils-ping \
  jq lldb llvm lua5.3 luajit luarocks make man-db meson neovim ninja-build \
  openssl pandoc pass pkg-config python-is-python3 python3 python3-pip \
  python3-venv ruby scdoc socat texinfo unzip valac wget wl-clipboard texinfo \
  unzip valac wget wl-clipboard xclip xdg-utils xterm xz-utils yank zstd

