# shellcheck shell=bash

#
# sh/paths.sh
#

# path functions
# --------------------

# remove given directories from a path string
_path_remove() {
  if (($# < 2)); then
    echo "error: ${FUNCNAME:-$0} needs a path string and at least one path to remove" 1>&2
    echo "usage: ${FUNCNAME:-$0} <path_string> <path>..." 1>&2
  fi

  [[ -z "$1" ]] && return

  local new_path=":${1}:"
  for p in "${@:2}"; do
    new_path="${new_path//":${p}:"/":"}"
    [[ "${new_path}" == ":" ]] && return
  done

  echo "${new_path:1:-1}"
}

# prepend given directories to a path string
_path_prepend() {
  if (($# < 2)); then
    echo "error: ${FUNCNAME:-$0} needs a path string and at least one path to prepend" 1>&2
    echo "usage: ${FUNCNAME:-$0} <path_string> <path>..." 1>&2
  fi

  local old_path="$1"
  local prepend
  for p in "${@:2}"; do
    if [[ -d "$p" ]] && [[ ":${prepend}:" != *":${p}:"* ]]; then
      if [[ ":${old_path}:" == *":${p}:"* ]]; then
        old_path="$(_path_remove "${old_path}" "$p")"
      fi
      prepend="${prepend:+"${prepend}:"}${p}"
    fi
  done

  echo "${prepend:+"${prepend}:"}${old_path}"
}

# append given directories to a path string
_path_append() {
  if (($# < 2)); then
    echo "error: ${FUNCNAME:-$0} needs a path string and at least one path to append" 1>&2
    echo "usage: ${FUNCNAME:-$0} <path_string> <path>..." 1>&2
  fi

  local old_path="$1"
  local append
  for p in "${@:2}"; do
    if [[ -d "$p" ]] && [[ ":${append}:" != *":${p}:"* ]]; then
      if [[ ":${old_path}:" == *":${p}:"* ]]; then
        old_path="$(_path_remove "${old_path}" "$p")"
      fi
      append="${append:+"${append}:"}${p}"
    fi
  done

  echo "${old_path}${append:+":${append}"}"
}

# remove directories from a path
remove-from-path() { PATH="$(_path_remove "${PATH}" "$@")"; export PATH; }
remove-from-infopath() { INFOPATH="$(_path_remove "${INFOPATH}" "$@")"; export INFOPATH; }
remove-from-pythonpath() { PYTHONPATH="$(_path_remove "${PYTHONPATH}" "$@")"; export PYTHONPATH; }

# prepend directories to a path if the directory exists
prepend-path() { PATH="$(_path_prepend "${PATH}" "$@")"; export PATH; }
prepend-infopath() { INFOPATH="$(_path_prepend "${INFOPATH}" "$@")"; export INFOPATH; }
prepend-pythonpath() { PYTHONPATH="$(_path_prepend "${PYTHONPATH}" "$@")";  export PYTHONPATH; }

# append directories to a path if the directory exists
append-path() { PATH="$(_path_append "${PATH}" "$@")"; export PATH; }
append-infopath() { INFOPATH="$(_path_append "${INFOPATH}" "$@")"; export INFOPATH; }
append-pythonpath() { PYTHONPATH="$(_path_append "${PYTHONPATH}" "$@")"; export PYTHONPATH; }

# package managers and binary paths
# --------------------

# homebrew
if command -v brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_PREFIX
  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
  export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
  prepend-path "${HOMEBREW_PREFIX}/sbin"
  prepend-path "${HOMEBREW_PREFIX}/bin"
  prepend-infopath "${HOMEBREW_PREFIX}/share/info"
  HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
  if [[ -f "${HOMEBREW_COMMAND_NOT_FOUND_HANDLER}" ]]; then
    # shellcheck source=/dev/null
    source "${HOMEBREW_COMMAND_NOT_FOUND_HANDLER}";
  fi
fi

# home local bin
prepend-path "${HOME}/.local/bin"

# program environment variables
# --------------------

# ansible
export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export ANSIBLE_LOCAL_TEMP_DIR="${ANSIBLE_HOME}/tmp"
export ANSIBLE_SSH_CONTROL_PATH_DIR="${ANSIBLE_HOME}/cp"

# cargo
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
prepend-path "${CARGO_HOME}/bin"

# claude
export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME}/claude"

# continue
export CONTINUE_GLOBAL_DIR="${XDG_DATA_HOME}/continue"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# gnu coreutils
if [[ "$(uname)" == "Darwin" ]] && [[ -d "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin" ]]; then
  prepend-path "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
fi

# golang
export GOPATH="${XDG_DATA_HOME}/go"

# gpg
GPG_TTY="$(tty)"
export GPG_TTY

# less
export LESS="-QR --no-vbell"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
LESS_TERMCAP_mb="$(tput bold && tput setaf 1)"
LESS_TERMCAP_md="$(tput bold && tput setaf 74)"
LESS_TERMCAP_me="$(tput sgr0)"
LESS_TERMCAP_se="$(tput sgr0)"
LESS_TERMCAP_so="$(tput bold && tput setaf 16 && tput setab 60)"
LESS_TERMCAP_ue="$(tput rmul)"
LESS_TERMCAP_us="$(tput smul && tput setaf 28)"
export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_se
export LESS_TERMCAP_so
export LESS_TERMCAP_ue
export LESS_TERMCAP_us

# lesspipe
if command -v lesspipe.sh &>/dev/null; then
  eval "$(SHELL=/bin/sh lesspipe.sh)"
fi

# man
export MANPAGER="less -QR --no-vbell"

# npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export npm_config_cache="${XDG_CACHE_HOME}/npm"
prepend-path "${XDG_DATA_HOME}/npm/bin"

# nvim
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi
export VISUAL="${EDITOR}"
export SUDO_EDITOR="${EDITOR}"

# nvm
export NVM_DIR="${XDG_DATA_HOME}/nvm"
if [[ -d "${NVM_DIR}" ]]; then
  # shellcheck source=/dev/null
  source "${NVM_DIR}/nvm.sh" || true
  # shellcheck source=/dev/null
  source "${NVM_DIR}/bash_completion" || true
fi

# ollama
export OLLAMA_API_BASE="http://localhost:11434"

# pass
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

# pex
export PEX_ROOT="${XDG_CACHE_HOME}/pex"

# pyenv
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

# python
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export MPLCONFIGDIR="${XDG_CONFIG_HOME}/matplotlib"
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
# export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# ruby
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
prepend-path "${GEM_HOME}/bin"

# rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# tldr
export TLDR_CACHE_DIR="${XDG_CACHE_HOME}/tldr"

# wine
export WINEPREFIX="${XDG_DATA_HOME}/wine"
