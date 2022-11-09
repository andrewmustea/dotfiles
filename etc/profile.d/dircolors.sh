#!/bin/sh

#
# /etc/profile.d/dircolors.sh
#

if [ -f "/etc/dircolors" ] ; then
    eval $(dircolors -b /etc/dircolors)
elif [ -f "$HOME/.dircolors" ] ; then
    eval $(dircolors -b $HOME/.dircolors)
fi

