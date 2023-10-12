#!/bin/sh

#
# /etc/profile.d/dircolors.sh
#

if [ -r "${HOME}/.dircolors" ]; then
  eval "$(dircolors -b "${HOME}/.dircolors")"
elif [ -r "/etc/dircolors" ]; then
  eval "$(dircolors -b /etc/dircolors)"
fi

