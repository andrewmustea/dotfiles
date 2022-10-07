#!/bin/sh

#
# /etc/profile.d/ubuntu.sh
#

# golang
GO_BIN=/usr/local/go/bin
if [ -d "$GO_BIN" ]; then
    case ":$PATH:" in
        *:"$GO_BIN":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$GO_BIN"
    esac
fi

# nala
which nala >/dev/null 2>&1 && alias apt='nala'

