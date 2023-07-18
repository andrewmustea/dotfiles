#!/bin/bash

#
# ~/.config/fzf/fzf.bash
#

# check if fzf is available
if ! hash fzf &>/dev/null; then
  echo "fzf not found" 1>&2
  return 1
fi

# XDG directory
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# possible fzf paths
local_fzf="${XDG_DATA_HOME}/fzf"
homebrew_fzf="$(brew --prefix)/opt/fzf"
system_fzf="/usr/share/fzf"

# get fzf paths depending on installation method
unset autocomplete key_bindings fzf_path
if [[ -d "${local_fzf}" ]]; then
  autocomplete="${local_fzf}/shell/completion.bash"
  key_bindings="${local_fzf}/shell/key-bindings.bash"

  # update local git fzf
  update-fzf() {
    git -C "${XDG_DATA_HOME}/fzf" pull
    "${XDG_DATA_HOME}/fzf/install" --xdg --bin
  }
elif [[ -d "${homebrew_fzf}" ]]; then
  autocomplete="${homebrew_fzf}/script/completion.bash"
  key_bindings="${homebrew_fzf}/script/key-bindings.bash"
elif [[ -d "${system_fzf}" ]]; then
  autocomplete="${system_fzf}/completion.bash"
  key_bindings="${system_fzf}/key-bindings.bash"
else
  echo "no fzf directory found" 1>&2
  unset autocomplete key_bindings fzf_path local_fzf system_fzf
  return 1
fi

# auto-completion
if [[ "$-" == *i* ]]; then
  source "${autocomplete}" 2>/dev/null
fi

# key bindings
source "${key_bindings}"

# colors
if [[ "${FZF_DEFAULT_OPTS}" != *color* ]]; then
  OPTS=("--color=fg:#888888,hl:#b030a0"
        "--color=fg+:#bbbbbb,bg+:#151a1e,hl+:#36a3d9"
        "--color=info:#508040,prompt:#8030e0,pointer:#f06722"
        "--color=marker:#0040bb,spinner:#b02828,header:#0078c8")
  FZF_DEFAULT_OPTS+=" ${OPTS[*]}"
  export FZF_DEFAULT_OPTS
fi

unset autocomplete key_bindings fzf_path local_fzf system_fzf

