#!/bin/sh

# shell script designed to setup a new system as quick as possible


# --------------------
# environment
# --------------------

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

unset RELEASE
if [ "$DISTRO" = "arch" ]; then
    if which paru >/dev/null 2>&1; then
        alias dist_install="paru -S --noconfirm "
    elif which yay >/dev/null 2>&1; then
        alias dist_install="yay -S --noconfirm "
    else
        alias dist_install="sudo pacman -S --noconfirm "
    fi
elif [ "$DISTRO" = "ubuntu" ]; then
    alias dist_install="sudo nala install -y "
    RELEASE=$(lsb_release -r | awk '{ split($2, a, "."); print a[1] }')
elif [ "$DISTRO" = "debian" ]; then
    alias dist_install="sudo nala install -y "
else
    echo "Distro is not supported: $DISTRO"
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
# $2 - release name
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

    exe="$2"
    uri="https://github.com/$1/releases/latest/download/$exe"

    wget -cq --show-progress "$uri" -P "$dir"
}


# --------------------
# XDG directories
# --------------------

[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=~/.config
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"


# --------------------
# locale
# --------------------
if [ "$DISTRO" = "debian" ] || [ "$DISTRO" = "ubuntu" ]; then
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8
fi


# --------------------
# distro specific
# --------------------

if [ "$DISTRO" = "ubuntu" ]; then
    # nala
    ./setup/nala.sh

    # no motd
    sudo chmod -x /etc/update-motd.d/*

    # eliminate snap (eww) and motd
    sudo nala purge snapd update-motd show-motd motd-news-config

    # ppas
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo add-apt-repository -y ppa:flatpak/stable
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

    # pacstall
    sudo bash -c "$(curl -fsSL https://git.io/JsADh ||
        wget -q --show-progress https://git.io/JsADh -O -)"

    # homebrew
    bash -c "$(curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # sudo update
    sudo_ver="$(sudo --version | awk -F'[ .]' 'NR==1{ print $4 }')"
    if [ "$sudo_ver" -lt 9 ]; then
        get_github_latest "sudo-project/sudo" "sudo_.*ubu$RELEASE" "/tmp/sudo"
        sudo dpkg -i "$(find "/tmp/sudo/" -name "sudo_*")"
        rm -rf "/tmp/sudo"
    fi

    sudo cp etc/sudoers.d/disable_sudo_admin_successful /etc/sudoers.d/
elif [ "$DISTRO" = "debian" ]; then
    ./setup/nala.sh
fi



# --------------------
# other
# --------------------

sudo chown "$USER:$USER" ~ -R

dist_install \
    autoconf automake bash-completion binutils bison build-essential chrpath \
    clang clang-format clang-tools clangd cmake cmatrix cmatrix-xfont \
    command-not-found cpio curl debianutils diffstat doxygen flex g++ gawk \
    gcc gdb gem gettext git gpg iputils-ping jq libegl1-mesa libgee-0.8-dev \
    libgmp-dev libjsonrpc-glib-1.0-dev liblua5.3-dev liblz4-tool \
    libsdl1.2-dev libssl-dev libtool libtool-bin libvala-dev lldb llvm lua5.3 \
    luajit luarocks make man-db mesa-common-dev meson neovim ninja-build \
    openssl pandoc pass pkg-config pylint python-is-python3 python3 \
    python3-git python3-pip python3-venv ruby-dev scdoc socat texinfo unzip \
    valac wget wl-clipboard xdg-utils xterm xz-utils yank zstd

# other setup
./setup/fzf.sh
./setup/rust.sh
./setup/haskell.sh
./setup/azure.sh
./setup/go.sh
./setup/nvm.sh
./setup/lua-lsp.sh


# --------------------
# git
# --------------------

# create git config
mkdir --parents ~/.config/git
touch ~/.config/git/config

# set git config user.name
username="$(git config --global user.name)"
while [ -z "$username" ]; do
    printf "Enter git username: "
    read -r response
    case "$response" in
        "")
            echo "No input detected."
            ;;
        *)
            echo "Setting git username to: '$response'"
            git config --global user.name "$response"
            break
            ;;
    esac
done

# set git config user.email
email="$(git config --global user.email)"
while [ -z "$email" ]; do
    printf "Enter git email: "
    read -r response
    case "$response" in
        "")
            echo "No input detected."
            ;;
        *)
            echo "Setting git email to: '$response'"
            git config --global user.email "$response"
            break
            ;;
    esac
done

# append git config settings
cat git/config >> ~/.config/git/config


# --------------------
# pip
# --------------------

pip install -I --upgrade pynvim pylint gitlint codespell


# --------------------
# nvim
# --------------------

dist_install neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# --------------------
# gnupg, pass
# --------------------

dist_install gpg pass

if ! pass ls; then
    key="$(gpg --list-secret-keys --keyid-format LONG |
        awk '/sec/{if (length($2) > 0) print $2}')"
    key="${key##*/}"

    if [ -z "$key" ]; then
        if gpg --full-gen-key; then
            echo "Error generating key. Not initializing password store."
        else
            export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
            pass init "$key"
        fi
    fi
fi


# --------------------
# git-credential-manager
# --------------------

if [ "$DISTRO" = "arch" ]; then
    dist_install git-credential-manager-core-bin
    git-credential-manager-core configure &&
    git-credential-manager-core diagnose &&
    rm gcm-diagnose.log
elif ! which git-credential-manager-core >/dev/null 2>&1; then
    get_github_latest "GitCredentialManager/git-credential-manager" \
        "amd64.*deb" "/tmp/gcm"
    sudo dpkg -i "$(find "/tmp/gcm/" -name "gcm_*.deb")"
    rm -rf "/tmp/gcm"

    git-credential-manager-core configure &&
    git-credential-manager-core diagnose &&
    rm gcm-diagnose.log
fi


# --------------------
# vscode
# --------------------

MAXUSERWATCHES="fs.inotify.max_user_watches = 524288"
if ! grep -q "$MAXUSERWATCHES" /etc/sysctl.conf; then
    echo "$MAXUSERWATCHES" | sudo tee -a /etc/sysctl.conf
fi

