#!/bin/bash

#
# /etc/profile.d/wsl.sh
#

# run powershell command
run-ps() {
  if (( $# == 0 )); then
    echo "error: no command provided" 1>&2
    echo "usage: run-ps <command>" 1>&2
    return 1
  fi

  powershell.exe -command "$*" | tr -d "\r"
}

# windows user paths
WINHOME="$(wslpath "$(run-ps "echo \"\${env:USERPROFILE}\"")")"
WINDOC="$(wslpath "$(run-ps "[Environment]::GetFolderPath(\"MyDocuments\")")")"
export WINHOME
export WINDOC
export WINDOWN="${WINHOME}/Downloads"

# directory functions
winhome() { cd "${WINHOME}" || return 1; }
windoc() { cd "${WINDOC}" || return 1; }
windown() { cd "${WINDOWN}" || return 1; }

# print path
print-path-wsl() {
  echo "${PATH//":"/"\n"}" | grep -v "^/mnt/c/"
}

