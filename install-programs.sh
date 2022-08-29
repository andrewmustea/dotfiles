#!/bin/sh

# shell script designed to setup a new system as quick as possible

# TODO
# lua liblua5.3-dev luarocks
# ruby-dev gem
# openssl libssl-dev cmake gcc g++ make autoconf automake gdb build-essential binutils libgmp-dev cmake clang clangd clang-format

# setup environment

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

unset RELEASE
if [ "$DISTRO" = "arch" ]; then
    alias dist_install="sudo pacman -S --noconfirm "
elif [ "$DISTRO" = "ubuntu" ]; then
    alias dist_install="sudo apt install -y "
    RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
else
    echo "Unknown or unimplemented distro: $DISTRO"
    exit 1
fi


# --------------------
# check XDG
# --------------------

[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"


# --------------------
# pip
# --------------------

dist_install pip
sudo -H pip install --upgrade pynvim pylint gitlint bashate codespell


# --------------------
# git
# --------------------

# if ~/.config/git/config not exists
mkdir --parents ~/.config/git/
touch ~/.config/git/config
#cat git/config >> ~/.config/git/config

# if name not set
USERNAME=
while [ -z "$USERNAME" ]; do
    printf "Enter git username: "
    read -r response
    case "$response" in
        "")
            echo "No input detected."
            ;;
        *)
            USERNAME="$response"
            ;;
    esac
done

git config --global user.name "$USERNAME"

# if email not set
EMAIL=
while [ -z "$EMAIL" ]; do
    printf "Enter git email: "
    read -r response
    case "$response" in
        "")
            echo "No input detected."
            ;;
        *)
            EMAIL="$response"
            echo "Setting email to: '$EMAIL'"
            ;;
    esac
done

git config --global user.email "$EMAIL"


# --------------------
# Ubuntu only
# --------------------

if [ "$DISTRO" = "ubuntu" ]; then

    # no motd
    sudo chmod -x /etc/update-motd.d/*

    # eliminate snap (gross)
    sudo apt purge snapd
    # ppas
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo add-apt-repository -y ppa:git-core/ppa

    sudo apt install git

    # node
    curl -fsSL https://deb.nodesource.com/setup_18.x | command sudo bash

    # sudo update
    url_latest="https://api.github.com/repos/sudo-project/sudo/releases/latest"
    info="$(curl -s "$url_latest")"
    name="$(printf "%s" "$info" | grep "\"name\".*sudo_.*ubu$RELEASE" | \
        awk '/name/ { gsub(/[",]/,""); print $2}')"
    link="$(printf "%s" "$info" | grep "\"browser_download_url\".*$name" | \
        awk '/browser_download_url/ { gsub(/[",]/,""); print $2}')"

    wget -cq "$link" -P /tmp
    sudo dpkg -i "/tmp/$name"
    rm "/tmp/$name"
fi


# --------------------
# node
# --------------------

dist_install nodejs
sudo npm install -g npm@latest neovim commitizen


# --------------------
# nvim
# --------------------

dist_install neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# --------------------
# fzf
# --------------------

if [ -n "$ARCH" ]; then
    dist_install fzf
else
    ./setup/fzf.sh
fi


# --------------------
# go
# --------------------

# if ubuntu/debian, download go from google
# and if go isnt installed
if [ "$DISTRO" = "ubuntu" ]; then
    wget -cq https://go.dev/dl/go1.19.linux-amd64.tar.gz -P /tmp && \
        sudo rm -rf /usr/local/go && \
        sudo tar -C /usr/local -xzf /tmp/go1.19.linux-amd64.tar.gz && \
        rm /tmp/go1.19.linux-amd64.tar.gz
elif [ "$DISTRO" = "arch" ]; then
    sudo pacman -S golang
fi

# TODO add to path

# TODO: move to setup
if [ "$DISTRO" = "arch" ]; then
    sudo pacman -S shfmt golines glow lemonade
else
    go install mvdan.cc/sh/v3/cmd/shfmt@latest
    go install github.com/segmentio/golines@latest
    go install github.com/charmbracelet/glow@latest
    go install github.com/lemonade-command/lemonade@latest
fi


# --------------------
# nala
# --------------------

[ "$DISTRO" = "ubuntu" ] && ./nala/setup-nala.sh


# --------------------
# rust
# --------------------

[ "$DISTRO" != "arch" ] && ./rust/setup-rust.sh


# --------------------
# haskell
# --------------------

[ "$DISTRO" != "arch" ] && ./haskell/setup-haskell.sh


# --------------------
# gnupg, pass
# --------------------

# if ubuntu
dist_install gpg pass

mkdir --parents "$XDG_DATA_HOME/gnupg"
chmod 700 "$XDG_DATA_HOME/gnupg"

#if key not generated
# TODO: see if you can enter them pre
if gpg --full-generate-key; then
    echo "Error generating key."
    exit
fi
# TODO get pub key
PUB_KEY=
pass init "$PUB_KEY"


# --------------------
# azure cli
# --------------------

# if ubuntu/deb, use deb package
if [ "$DISTRO" = "ubuntu" ]; then
    sudo apt update
    sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg

    curl -sL https://packages.microsoft.com/keys/microsoft.asc |
        gpg --dearmor |
        command sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    command sudo tee /etc/apt/sources.list.d/azure-cli.list

    sudo apt update
    sudo apt install -y azure-cli
# else use generic linux package
fi


# --------------------
# git-credential-manager
# --------------------

if [ "$DISTRO" = "ubuntu" ]; then
    wget -cq https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.785/gcm-linux_amd64.2.0.785.deb -P /tmp
    sudo dpkg -i /tmp/gcm-linux_amd64.2.0.785.deb
    rm /tmp/gcm-linux_amd64.2.0.785.deb

    git-credential-manager-core configure &&
    git-credential-manager-core diagnose
    # TODO delete diagnose log
fi


# --------------------
# lua lsp
# --------------------

if ! which lua-language-server >/dev/null 2>&1; then
    dist_install ninja-build
    # check if gcc >= 9?
    git clone  --depth=1 https://github.com/sumneko/lua-language-server "$XDG_DATA_HOME/lua-language-server"
    cd "$XDG_DATA_HOME/lua-language-server" || exit 1
    git submodule update --depth 1 --init --recursive

    cd 3rd/luamake || exit 1
    ./compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild

    case ":$PATH:" in
        *:"$XDG_DATA_HOME/lua-language-server/bin":*)
            ;;
        *)
            export PATH="$PATH:$XDG_DATA_HOME/lua-language-server/bin"
            ;;
    esac
fi

# vscode
MAXUSERWATCHES="fs.inotify.max_user_watches = 524288"
if ! grep -q "$MAXUSERWATCHES" /etc/sysctl.conf; then
    echo "$MAXUSERWATCHES" | command sudo tee -a /etc/sysctl.conf
fi

