#!/bin/bash

#
# ./setup/ubuntu.sh
#

# setup a new ubuntu system

# --------------------
# environment
# --------------------

# error and warning colors
RED="$(tput setaf 1)"
YLW="$(tput setaf 3)"
CLR="$(tput sgr0)"
readonly RED YLW CLR

# warning message
warn-msg() {
  echo -e "${YLW}Warning${CLR}: $*" 1>&2
}

# error message
error-msg() {
  echo -e "${RED}Error${CLR}: $*" 1>&2
}

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# check if ubuntu
if [[ "${NAME}" != "ubuntu" ]]; then
  error-msg "current system is not Ubuntu"
  exit 1
fi

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# XDG directories
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"

# package manager
if hash nala &>/dev/null || sudo ./nala.sh; then
  readonly PACKAGE_MANAGER="nala"
else
  readonly PACKAGE_MANAGER="apt"
fi

# --------------------
# other
# --------------------

# terminal pinentry
sudo update-alternatives --install /usr/bin/pinentry pinentry /usr/bin/pinentry-curses 100

# no motd
sudo chmod -x /etc/update-motd.d/*

# ppas
sudo add-apt-repository -y ppa:flatpak/stable
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

# locale
sudo locale-gen en_US.UTF-8
sudo update-locale LANG="en_US.UTF-8"

# ensure home directory ownership
chown -R "${USER}:${USER}" "${HOME}"

# --------------------
# packages
# --------------------

# remove snaps and motd
sudo "${PACKAGE_MANAGER}" remove --purge -y snapd update-motd show-motd motd-news-config

# packages
sudo "${PACKAGE_MANAGER}" install -y \
  aptitude autoconf automake bash-completion binutils \
  binutils-aarch64-linux-gnu bison build-essential ccache chrpath clang \
  clang-format clang-tools clangd cmake cmatrix-xfont cmatrix \
  command-not-found cpio curl debianutils diffstat doxygen flex g++ \
  g++-aarch64-linux-gnu gawk gcc gcc-aarch64-linux-gnu gdb gettext git gpg \
  iputils-ping jq libegl1-mesa libgee-0.8-dev libgmp-dev \
  libjsonrpc-glib-1.0-dev liblua5.3-dev liblz4-tool libsdl1.2-dev libssl-dev \
  libtool libtool-bin libvala-dev lldb llvm lua5.3 luajit luarocks make \
  man-db mesa-common-dev meson mtools neovim ninja-build openssl pandoc pass \
  pkg-config python-is-python3 python3 python3-pip python3-venv scdoc socat \
  texinfo unzip valac wget wl-clipboard xclip xdg-utils xterm xz-utils yank \
  zstd

# homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# other setup scripts
sudo ./setup/azure.sh
sudo ./setup/fzf.sh
sudo ./setup/github-cli.sh
sudo ./setup/go.sh
sudo ./setup/nvm.sh
sudo ./setup/rust.sh
sudo ./setup/sudo.sh

# --------------------
# git
# --------------------

# create or move git config
readonly GIT_CONFIG="${XDG_CONFIG_HOME}/git/config"
if ! [[ -f "${GIT_CONFIG}" ]]; then
  if [[ -f ~/.gitconfig ]]; then
    mv ~/.gitconfig "${GIT_CONFIG}"
  else
    mkdir -p "${XDG_CONFIG_HOME}/git"
    touch "${GIT_CONFIG}"
  fi
fi

# get git username and email
username="$(git config --global user.name)"
email="$(git config --global user.email)"

# set git username
while [[ -z "${username}" ]]; do
  printf "Enter your git username: "
  read -r response
  case "${response}" in
    "")
      error-msg "no input detected"
      ;;
    *)
      echo "Setting git username to: '${response}'"
      git config --global user.name "${response}"
      break
      ;;
  esac
done

# set git email
while [[ -z "${email}" ]]; do
  printf "Enter git email: "
  read -r response
  case "${response}" in
    "")
      error-msg "no input detected"
      ;;
    *)
      echo "Setting git email to: '${response}'"
      git config --global user.email "${response}"
      break
      ;;
  esac
done

# --------------------
# pip
# --------------------

pip install --user --ignore-installed --upgrade \
  codespell esbonio gitlint oelint-adv pylint pynvim sphinx \
  sphinx-rtd-dark-mode sphinx-rtd-theme

# --------------------
# nvim
# --------------------

git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  "${XDG_DATA_HOME}/nvim/site/pack/packer/start/packer.nvim"

# --------------------
# gnupg, pass
# --------------------

if ! pass ls; then
  key="$(gpg --list-secret-keys --keyid-format LONG |
    awk '/sec/{if (length($2) > 0) print $2}')"
  key="${key##*/}"

  if [[ -n "${key}" ]] || gpg --full-gen-key; then
    export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
    pass init "${key}"
  else
    error-msg "couldn't generate gpg key"
  fi
fi

# --------------------
# git-credential-manager
# --------------------

if sudo ./git-credential-manager.sh; then
  # add setup to config
  if ! grep -q "^\[credential\]\$" "${GIT_CONFIG}"; then
    {
      echo -e "\n[credential]"
      echo -e "\thelper ="
      echo -e "\thelper = /usr/local/bin/git-credential-manager"
      echo -e "\tcredentialStore = gpg"
      echo -e "\tguiPrompt = false"
    } >> "${GIT_CONFIG}"
  fi

  # configure
  git-credential-manager configure
fi

# --------------------
# vscode
# --------------------

# increase number of file watches for vscode
readonly MAXUSERWATCHES="fs.inotify.max_user_watches = 524288"
if ! grep -q "^${MAXUSERWATCHES}\$" /etc/sysctl.conf; then
  echo "${MAXUSERWATCHES}" | sudo tee -a /etc/sysctl.conf
fi

