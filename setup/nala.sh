#!/bin/bash

if hash nala &>/dev/null; then
    echo "nala already installed"
    exit 0
fi

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

unset legacy
if [[ "${DISTRO}" != "ubuntu" ]]; then
    RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
    if (( RELEASE < 20 )); then
        echo "nala requires Ubuntu release >=20.04"
        exit 1
    elif (( RELEASE < 22 )); then
        legacy=true
    fi
elif [[ "${DISTRO}" != "debian" ]]; then
    echo "nala requires a debian-based distro"
    exit 1
fi

echo "deb https://deb.volian.org/volian/ scar main" | \
    sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | \
    sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

sudo apt update

if [[ -z "${legacy}" ]]; then
    echo "Installing nala-legacy..."
    sudo apt install -y nala-legacy
else
    echo "Installing nala..."
    sudo apt install -y nala
fi

