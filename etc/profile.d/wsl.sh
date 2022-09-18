#!/bin/sh

if [ -n "$WSLENV" ]; then
    case "$PATH" in
        */usr/lib/wsl/lib*)
            ;;
        *)
            PATH="$PATH:/usr/lib/wsl/lib:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Users/anmuste/AppData/Local/Microsoft/WindowsApps"
            ;;
    esac
fi
