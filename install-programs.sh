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
# github functions
# --------------------

# get a json message of a repository's latest release
# $1 - github repository [github_username/repository]
get_latest_release_data() {
    if [ -z "$1" ]; then
        echo "Missing repository details"
        echo "Usage: get_github_data <github_username/repository>"
        exit 1
    elif [ -n "$2" ]; then
        echo "Too many arguments: $*"
        echo "Usage: get_github_data <github_username/repository>"
        exit 1
    fi

    curl -s "https://api.github.com/repos/$1/releases/latest"
}

# get name of latest release
# $1 - github data json file
# $2 - search pattern for name
get_release_name() {
    if [ -z "$2" ]; then
        echo "Not enough arguments: $*"
        echo "get_github_name <github_json> <search-pattern>"
        exit 1
    elif [ -n "$3" ]; then
        echo "Too many arguments: $*"
        echo "get_github_name <github_json> <search-pattern>"
        exit 1
    fi

    printf "%s" "$1" | grep "\"name\".*$2" | \
        awk '/name/ { gsub(/[",]/,""); print $2}'
}

# get the download url for a given github release and name
# $1 - github data json file
# $2 - name
get_release_url() {
    if [ -z "$1" ]; then
        echo "Missing argument"
        echo "Usage: get_release_url <github_json> <release_name>"
        exit 1
    elif [ -n "$3" ]; then
        echo "Too many arugments: $*"
        echo "Usage: get_release_url <github_json> <release_name>"
        exit 1
    fi

    printf "%s" "$1" | grep "\"browser_download_url\".*$2" | \
        awk '/browser_download_url/ { gsub(/[",]/,""); print $2}'
}

# get latest release from github
# $1 - repository [github_name/repository]
# $2 - search pattern for name
# $3 - local save directory (optional)
get_github_latest() {
    dir="."
    if [ -z "$2" ]; then
        echo "Not enough arguments: $*"
        echo "get-github-latest <repository> <search-pattern> [DIR]"
        exit 1
    elif [ -n "$4" ]; then
        echo "Too many arguments: $*"
        echo "get-github-latest <repository> <search-pattern> [DIR]"
        exit 1
    elif [ -n "$3" ]; then
        dir=$3
    fi

    info="$(get_latest_release_data "$1")"
    name="$(get_release_name "$info" "$2")"
    link="$(get_release_url "$info" "$name")"

    wget -cq "$link" -P "$dir"
}


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
    # nala
    ./setup/nala.sh

    # no motd
    sudo chmod -x /etc/update-motd.d/*

    # eliminate snap (gross) and motd
    sudo apt purge snapd update-motd show-motd
    # ppas
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo add-apt-repository -y ppa:git-core/ppa

    sudo apt install git

    # node
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash

    # sudo update
    sudo_ver="$(sudo --version | awk -F'[ .]' 'NR==1{ print $4 }')"
    if [ "$sudo_ver" -lt 9 ]; then
        get_github_latest "sudo-project/sudo" "sudo_.*ubu$RELEASE" "/tmp/sudo"
        sudo dpkg -i "$(find "/tmp/sudo/" -name "sudo_*")"
        rm -rf "/tmp/sudo"
    fi
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

if [ "$DISTRO" = "arch" ]; then
    dist_install rust
else
    ./rust/setup-rust.sh
fi


# --------------------
# haskell
# --------------------

if [ "$DISTRO" = "arch" ]; then
    dist_install rust
else
    ./haskell/setup-haskell.sh
fi


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
        sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] \
        https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

    sudo apt update
    sudo apt install -y azure-cli
# else use generic linux package
fi


# --------------------
# git-credential-manager
# --------------------

if [ "$DISTRO" = "ubuntu" ]; then
    get_github_latest "GitCredentialManager/git-credential-manager" \
        "amd64.*deb" "/tmp/gcm"
    sudo dpkg -i "$(find "/tmp/sudo/" -name "gcm_*.deb")"
    rm -rf "/tmp/sudo"

    git-credential-manager-core configure &&
    git-credential-manager-core diagnose &&
    rm gcm-diagnose.log
fi


# --------------------
# lua lsp
# --------------------

if ! which lua-language-server >/dev/null 2>&1; then
    dist_install ninja-build
    # check if gcc >= 9?
    git clone --depth=1 https://github.com/sumneko/lua-language-server \
        "$XDG_DATA_HOME/lua-language-server"
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


# --------------------
# vscode
# --------------------

MAXUSERWATCHES="fs.inotify.max_user_watches = 524288"
if ! grep -q "$MAXUSERWATCHES" /etc/sysctl.conf; then
    echo "$MAXUSERWATCHES" | sudo tee -a /etc/sysctl.conf
fi

