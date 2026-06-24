# shellcheck shell=bash

#
# sh/functions.sh
#

# print path directories separated by newlines
print-path() {
  echo "${1:-"${PATH}"}" | tr ':' '\n'
}

# find a process
psgrep() {
  pgrep "$@" | xargs -r ps -fp
}

# find and kill processes
pskill() {
  kill -9 "$(psgrep "$@" | awk 'NR>1 { print $2 }')"
}

# extract from a compressed file
extract() {
  if (($# == 0)); then
    echo "error: missing file argument" 1>&2
    echo "usage: ${FUNCNAME:-$0} <file> [options]" 1>&2
    return 1
  fi

  case "$1" in
    *.tar.bz2) tar xvjf "$@" ;;
    *.tar.gz) tar xvzf "$@" ;;
    *.tar.xz) tar xvf "$@" ;;
    *.bz2) bunzip2 "$@" ;;
    *.gz) gunzip "$@" ;;
    *.rar) unrar x "$@" ;;
    *.tar) tar xvf "$@" ;;
    *.tbz2) tar xvjf "$@" ;;
    *.tgz) tar xvzf "$@" ;;
    *.zip) unzip "$@" ;;
    *.Z) uncompress "$@" ;;
    *.7z) 7z x "$@" ;;
    *)
      echo "error: unknown compressed file type '.${1#*.}'" 1>&2
      return 1
      ;;
  esac
}

# get the clipboard provider
if [[ "$(uname)" == "Darwin" ]]; then
  export _CLIPBOARD_PROVIDER="pbcopy"
elif [[ -n "${WAYLAND_DISPLAY}" ]]; then
  export _CLIPBOARD_PROVIDER="wl-copy"
else
  export _CLIPBOARD_PROVIDER="xsel --clipboard --input"
fi

# copy input into the clipboard
copy() {
  printf "%s" "$*" | "${_CLIPBOARD_PROVIDER}"
}

# copy a file's contents into the clipboard
copyfile() {
  if (($# != 1)); then
    echo "error: ${FUNCNAME:-$0} needs exactly one file" 1>&2
    echo "usage: ${FUNCNAME:-$0} <file>"
    return 1
  elif [[ ! -f "$1" ]]; then
    echo "error: '$1' is not a file" 1>&2
    return 1
  fi
  "${_CLIPBOARD_PROVIDER}" <"$1"
}

# copy the current path into the clipboard
copypath() {
  if (($# != 0)); then
    echo "error: ${FUNCNAME:-$0} doesn't take any arguments" 1>&2
    echo "usage: ${FUNCNAME:-$0}"
    return 1
  fi
  pwd | tr -d '\n' | "${_CLIPBOARD_PROVIDER}"
}

# print useful network interface information
ipinfo() {
  ifconfig -v | awk '
  /^(en)[0-9]+:/ {
    iface = $1; active = 1; inet = ""; mac = ""
  }
  /^utun[0-9]+:/ {
    iface = $1; vpn = 1; inet = ""; eiface = ""
  }
  /ether / { mac = $2 }
  /inet / { inet = $2 }
  /status: inactive/ { active = 0 }
  /type: / && active {
    type = substr($0, index($0, $2))
    print iface
    print "    inet: " inet
    print "    type: " type
    print "    mac: " mac
    print ""
    active = 0
  }
  /effective interface: / && vpn {
    eiface = $3
    print iface
    print "    inet: " inet
    print "    type: VPN"
    print "    effective interface: " eiface
    print ""
    vpn = 0
  }'
}

# get a random port number
random-port() {
  od -An -N2 -tu2 </dev/urandom | awk '{print 49152 + ($1 % (65536 - 49152))}'
}
