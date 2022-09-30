#!/bin/sh

if which nala >/dev/null 2>&1; then
    echo "nala already installed"
    exit
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [ "$DISTRO" = "debian" ]; then
    sudo apt install -y nala
    exit
elif [ "$DISTRO" != "ubuntu" ]; then
    echo "nala requires a debian-based distro"
    exit 1
fi

RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
if [ "$RELEASE" -lt 20 ]; then
    echo "nala requires Ubuntu release >=20.04"
    exit 1
fi

echo "deb https://deb.volian.org/volian/ scar main" | \
    sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | \
    sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > \
    /dev/null

sudo apt update

if [ "$RELEASE" -lt 22 ]; then
    echo "Installing nala-legacy..."
    sudo apt install -y nala-legacy
else
    echo "Installing nala..."
    sudo apt install -y nala
fi

