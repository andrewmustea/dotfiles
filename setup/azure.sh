#!/bin/sh

if which az >/dev/null 2>&1; then
    echo "azure-cli already installed"
    exit
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [ "$DISTRO" = "arch" ]; then
    if which paru >/dev/null 2>&1; then
        sudo paru -S --needed --noconfirm azure-cli
    elif which yay >/dev/null 2>&1; then
        sudo yay -S --needed --noconfirm azure-cli
    else
        echo "No AUR helper detected. Can't install azure-cli."
        exit 1
    fi
    exit
elif [ "$DISTRO" != "debian" ] && [ "$DISTRO" != "ubuntu" ]; then
    echo "Distro not supported: $DISTRO"
    exit 1
fi

pkgmgr='apt'
! which nala >/dev/null 2>&1 && pkgmgr='nala'

sudo "$pkgmgr" update
sudo "$pkgmgr" install -y ca-certificates curl apt-transport-https lsb-release gnupg

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] \
    https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo "$pkgmgr" update
sudo "$pkgmgr" install -y azure-cli

