#!/bin/bash

if hash az &>/dev/null; then
    echo "azure-cli already installed"
    exit 0
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [[ "${DISTRO}" = "arch" ]]; then
    if hash paru &>/dev/null; then
        sudo paru -S --needed --noconfirm azure-cli
    elif hash yay &>/dev/null; then
        sudo yay -S --needed --noconfirm azure-cli
    else
        echo "No AUR helper detected. Can't install azure-cli."
        exit 1
    fi
    exit 0
fi
if [[ "${DISTRO}" != "debian" ]] && [[ "${DISTRO}" != "ubuntu" ]]; then
    echo "Distro not supported: ${DISTRO}"
    exit 1
fi


pkgmgr='apt'
hash nala &>/dev/null && pkgmgr='nala'

sudo "${pkgmgr}" update
sudo "${pkgmgr}" install -y ca-certificates curl apt-transport-https \
                            lsb-release gnupg

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO="$(lsb_release -cs)"
echo "deb [arch=amd64] \
    https://packages.microsoft.com/repos/azure-cli/ ${AZ_REPO} main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo "${pkgmgr}" update
sudo "${pkgmgr}" install -y azure-cli

