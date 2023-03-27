#!/bin/bash

#
# ~/.config/fzf/fzf.bash
#

# check if fzf is available
if ! hash fzf &>/dev/null; then
  echo "no fzf binary found" 1>&2
  return 1
fi

# XDG directory
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# possible fzf paths
LOCAL_FZF="${XDG_DATA_HOME}/fzf/bin"
SYSTEM_FZF="/usr/share/fzf"

# get fzf paths depending on installation method
unset AUTOCOMPLETE KEY_BINDINGS FZF_PATH
if [[ -d "${LOCAL_FZF}" ]]; then
  FZF_PATH="${LOCAL_FZF}"
  AUTOCOMPLETE="${XDG_DATA_HOME}/fzf/shell/completion.bash"
  KEY_BINDINGS="${XDG_DATA_HOME}/fzf/shell/key-bindings.bash"

  # update local git fzf
  update-fzf() {
    git -C "${XDG_DATA_HOME}/fzf" checkout master
    git -C "${XDG_DATA_HOME}/fzf" pull
    "${FZF_DIR}/install" --xdg --bin
  }
elif [[ -d "${SYSTEM_FZF}" ]]; then
  FZF_PATH="${SYSTEM_FZF}"
  AUTOCOMPLETE="${SYSTEM_FZF}/completion.bash"
  KEY_BINDINGS="${SYSTEM_FZF}/key-bindings.bash"
else
  echo "no fzf directory found" 1>&2
  unset AUTOCOMPLETE KEY_BINDINGS FZF_PATH LOCAL_FZF SYSTEM_FZF
  return 1
fi

# add fzf to path
if [[ ":${PATH}:" != ":${FZF_PATH}:" ]]; then
  export PATH="${FZF_PATH}${PATH:+":${PATH}"}"
fi

# auto-completion
if [[ "$-" == *i* ]]; then
  source "${AUTOCOMPLETE}" 2>/dev/null
fi

# key bindings
source "${KEY_BINDINGS}"

# colors
if [[ "${FZF_DEFAULT_OPTS}" != *color* ]]; then
  OPTS=("--color=fg:#888888,hl:#b030a0"
        "--color=fg+:#bbbbbb,bg+:#151a1e,hl+:#36a3d9"
        "--color=info:#508040,prompt:#8030e0,pointer:#f06722"
        "--color=marker:#0040bb,spinner:#b02828,header:#0078c8")
  export FZF_DEFAULT_OPTS+=" ${OPTS[*]}"
fi

unset AUTOCOMPLETE KEY_BINDINGS FZF_PATH LOCAL_FZF SYSTEM_FZF

