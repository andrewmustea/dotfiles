#!/bin/bash

#
# /etc/profile.d/dotnet-cli-tools-bin-path.sh
#

rm -rf "${HOME}/.dotnet"

export DOTNET_ROOT="${XDG_DATA_HOME}/dotnet"
if [[ ":${PATH}:" != *":${DOTNET_ROOT}:"* ]]; then
  export PATH="${DOTNET_ROOT}${PATH:+":${PATH}"}"
fi

export DOTNET_TOOLS="${DOTNET_ROOT}/tools"
if [[ ":${PATH}:" != *":${DOTNET_TOOLS}:"* ]]; then
  export PATH="${DOTNET_TOOLS}${PATH:+":${PATH}"}"
fi

