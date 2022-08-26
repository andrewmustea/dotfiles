#!/bin/sh

if [ "$(lsb_release -i | awk '{ print $3 }')" != "Ubuntu" ]; then
    echo "Nala requires an Ubuntu release"
    exit
fi

RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
if [ "$RELEASE" -lt 20 ]; then
    echo -e "Nala requires Ubuntu OS release >=20.04 \nExiting"
    exit
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo "deb https://deb.volian.org/volian/ scar main" > /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key > /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg

apt update

RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
if [ "$RELEASE" -lt 22 ]; then
    echo "Installing nala-legacy..."
    apt install nala-legacy
else
    echo "Installing nala..."
    apt install nala
fi

