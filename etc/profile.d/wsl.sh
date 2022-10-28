#!/bin/bash

# add wsl path
case "$PATH" in
    */usr/lib/wsl/lib*)
        ;;
    *)
        PATH="$PATH:/usr/lib/wsl/lib:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/"
        ;;
esac

# run powershell command
run-ps() {
    if [[ $# -eq 0 ]]; then
        echo "Error: no command provided"
        echo "Usage: run-ps <command-string>"
        return 1
    fi

    pwsh="$(powershell.exe -command "$*" | sed 's/\\/\//g')"
    echo "${pwsh%$'\r'}"
}

# get path from windows path
get-winpath() {
    if ! [[ $# -eq 1 ]]; then
        echo "Error: bad arguments: $*"
        echo "Usage: get-winpath <path>"
        return 1
    fi

    winpath="$(wslpath "$1")"
    echo "${winpath%$'\r'}"
}

# windows paths
winuser="$(get-winpath "$(run-ps "echo \"\${env:USERPROFILE}\"")")"
export winuser
export windoc="$winuser/OneDrive - Microsoft/Documents"
export windown="$winuser/Downloads"

alias winuser='cd "$winuser"'
alias windoc='cd "$windoc"'
alias windown='cd "$windown"'

print-path() {
    printf "%s\n" "${PATH//:/$'\n'}" | grep -v '^/mnt/c/'
}

