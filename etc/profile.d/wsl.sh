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

  powershell.exe -command "$*" | tr -d "\r" | sed 's|\\|/|g'
}

# windows user paths
WINUSER="$(wslpath "$(run-ps "echo \"\${env:USERPROFILE}\"")")"
WINDOC="$(wslpath "$(run-ps "[Environment]::GetFolderPath(\"MyDocuments\")")")"
export WINUSER
export WINDOC
export WINDOWN="${WINUSER}/Downloads"

# directory functions
winuser() { cd "${WINUSER}" || return 1; }
windoc() { cd "${WINDOC}" || return 1; }
windown() { cd "${WINDOWN}" || return 1; }

# print path
print-path-wsl() {
  echo "${PATH//":"/"\n"}" | grep -v "^/mnt/c/"
}

