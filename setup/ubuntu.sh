#!/bin/bash

#
# ./setup/ubuntu.sh
#

# setup a new ubuntu system

# --------------------
# environment
# --------------------

# warning message
warn-msg() {
  echo -e "$(tput setaf 1)Warning$(tput sgr0): $*" 1>&2
}

# error message
error-msg() {
  echo -e "$(tput setaf 3)Error$(tput sgr0): $*" 1>&2
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

# get setup directory
SETUP_DIR="$(realpath "${BASH_SOURCE%/*}")"
readonly SETUP_DIR

# XDG directories
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"

# package manager
if hash nala &>/dev/null || "${SETUP_DIR}/nala.sh"; then
  readonly PACKAGE_MANAGER="nala"
else
  readonly PACKAGE_MANAGER="apt"
fi
sudo "${PACKAGE_MANAGER}" update && sudo "${PACKAGE_MANAGER}" upgrade -y

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
export NONINTERACTIVE=1
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# github-cli
"${SETUP_DIR}/github-cli.sh"
gh auth login

# other setup scripts
"${SETUP_DIR}/azure-cli.sh"
"${SETUP_DIR}/fzf.sh"
"${SETUP_DIR}/go.sh"
"${SETUP_DIR}/nvm.sh"
"${SETUP_DIR}/sudo.sh"

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
unset username email
username="$(git config --global user.name)"
email="$(git config --global user.email)"

# set git username
while [[ -z "${username}" ]]; do
  printf "Enter your git username: "
  read -r response
  case "${response}" in
    "")
      warn-msg "no input detected"
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
      warn-msg "no input detected"
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

# initialize pass if not done already
setup-pass() {
  if pass ls; then
    echo "pass already initialized"
    return 0
  fi

  local keys key

  # get list of secret gpg keys
  keys="$(gpg --list-secret-keys 2>/dev/null)"

  # generate a key if none exist
  if [[ -z "${keys}" ]] && gpg --full-gen-key; then
    keys="$(gpg --list-secret-keys 2>/dev/null)"
  else
    error-msg "couldn't generate gpg key"
    return 1
  fi

  # get key from keys
  key="$(echo "${keys}" | awk '/sec/{getline; print $1; exit }')"

  # export pass directory and initialize pass
  export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
  pass init "${key}"
}

# check if pass is initialized
if ! setup-pass; then
  echo "not initializing a password store" 1>&2
fi

# --------------------
# git-credential-manager
# --------------------

# install gcm if not installed already
if "${SETUP_DIR}/git-credential-manager.sh"; then
  # check if gcm is already added to gitconfig
  if ! grep -q "^\[credential\]\$" "${GIT_CONFIG}"; then
    {
      echo -e "\n[credential]"
      echo -e "\thelper ="
      echo -e "\thelper = /usr/local/bin/git-credential-manager"
      echo -e "\tcredentialStore = gpg"
      echo -e "\tguiPrompt = false"
    } >> "${GIT_CONFIG}"

    # configure
    git-credential-manager configure
  fi
fi

# --------------------
# vscode
# --------------------

# increase number of file watches for vscode
readonly MAXUSERWATCHES="fs.inotify.max_user_watches = 524288"
if ! grep -q "^${MAXUSERWATCHES}\$" /etc/sysctl.conf; then
  echo "${MAXUSERWATCHES}" | sudo tee -a /etc/sysctl.conf
fi

