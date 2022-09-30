#!/bin/sh

if which lua-language-server >/dev/null 2>&1; then
    echo "lua-language-server already installed"
    exit
fi

[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=~/.local/share

DISTRO="$(grep "^ID=" /etc/os-release | awk -F "=" '{ print $2 }')"

if [ "$DISTRO" = "arch" ]; then
    sudo pacman -S --needed --noconfirm lua-language-server
    exit
elif [ "$DISTRO" != "debian" ] && [ "$DISTRO" != "ubuntu" ]; then
    echo "Distro not supported: $DISTRO"
    exit 1
fi

if which nala >/dev/null 2>&1; then
    sudo nala install -y ninja-build
else
    sudo apt install -y ninja-build
fi

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
        export PATH="${PATH:+${PATH}:}$XDG_DATA_HOME/lua-language-server/bin"
        ;;
esac

