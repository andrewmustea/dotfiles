#!/bin/sh

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"
if [ "$DISTRO" != "ubuntu" ]; then
    echo "Nala requires an Ubuntu release"
    exit
fi

RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
if [ "$RELEASE" -lt 20 ]; then
    echo -e "Nala requires Ubuntu OS release >=20.04 \nExiting"
    exit
fi

echo "deb https://deb.volian.org/volian/ scar main" | \
    command sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | \
    command sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

apt update

if [ "$RELEASE" -lt 22 ]; then
    echo "Installing nala-legacy..."
    apt install nala-legacy
else
    echo "Installing nala..."
    apt install nala
fi

