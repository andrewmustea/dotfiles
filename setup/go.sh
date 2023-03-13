#!/bin/bash

# error message
error-msg() {
  echo -e "$(tput setaf 1)Error$(tput sgr0): $*" 1>&2
}

# check if user is root
if (( EUID == 0 )); then
  error-msg "don't run script as root"
  exit 1
fi

# XDG data directory
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# set GOPATH
export GOPATH="${DATA}/go"

# get os name
NAME="$(grep "^ID=" /etc/os-release | awk -F '=' '{ print $2 }')"
readonly NAME

# arch linux
if [[ "${NAME}" == "arch" ]]; then
  sudo pacman -S --needed --noconfirm golang
  exit 0
fi

# ubuntu
if [[ "${NAME}" == "ubuntu" ]]; then
  # get latest release version
  readonly MIRROR="https://github.com/golang/go"
  readonly PATTERN="^[0-9]\.[0-9][0-9][^rc|^beta]"
  VER="$(git ls-remote --tags "${MIRROR}" | awk -F "go" '{ print $2 }' | grep "${PATTERN}" | tail -n 1)"
  readonly VER

  # check if installed version needs to be updated
  readonly LOCAL="/usr/local/go/bin/go"
  if ! [[ -x "${LOCAL}" ]]; then
    echo "installing go v${VER}..."
  else
    # get current and new version numbers
    CURRENT="$("${LOCAL}" version | awk -F "[ ]|go" '{ print $5 }')"
    read -r C1 C2 C3 < <(echo "${CURRENT}" | awk -F '.' '{print $1, $2, $3}')
    read -r V1 V2 V3 < <(echo "${VER}" | awk -F '.' '{print $1, $2, $3}')
    readonly CURRENT C1 C2 C3 V1 V2 V3

    # check version numbers and exit if current version is the newest version
    if (( V1 <= C1 )) && (( V2 <= C2)); then
      if [[ -z "${V3}" ]] || ( [[ -n "${C3}" ]] && (( V3 <= C3 )) ); then
        echo "installed go v${CURRENT} is the latest version"
        exit 0
      fi
    fi

    echo "replacing go v${CURRENT} with v${VER}..."
  fi

  # create temporary directory
  readonly TEMP="/tmp/go"
  rm -rf "${TEMP}"
  mkdir "${TEMP}"

  # download tar file
  readonly FILE="go${VER}.linux-amd64.tar.gz"
  readonly SOURCE="https://go.dev/dl/${FILE}"
  if ! wget -cq --show-progress "${SOURCE}" -P "${TEMP}"; then
    error-msg "couldn't download tar file"
    rm -rf "${TEMP}"
    exit 1
  fi

  # clear the local go directory
  sudo rm -rf /usr/local/go

  # untar the go file
  if ! sudo tar -C /usr/local -xzf "${TEMP}/${FILE}"; then
    error-msg "couldn't untar: ${TEMP}/${FILE}"
    exit 1
  fi

  # remove the temp directory
  rm -rf "${TEMP}"

  # add go directory to path
  if [[ ":${PATH}:" != ":/usr/local/go/bin:" ]]; then
    export PATH="/usr/local/go/bin${PATH:+":${PATH}"}"
  fi

  exit 0
fi

# other
error-msg "unsupported distribution: '${NAME}'"
exit 1

