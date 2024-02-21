#!/bin/bash

#
# ~/.config/fzf/fzf.bash
#

# check if fzf is available
if ! hash fzf &>/dev/null; then
  echo "fzf not found" 1>&2
  return 1
fi

# homebrew directory
[[ -z "${HOMEBREW_PREFIX}" ]] && HOMEBREW_PREFIX="$(brew --prefix)" && export HOMEBREW_PREFIX

# check if homebrew fzf install exists
if [[ ! -d "${HOMEBREW_PREFIX}/opt/fzf" ]]; then
  echo "couldn't find homebrew fzf directory at '${HOMEBREW_PREFIX}/opt/fzf'" 1>&2
  return 1
fi

# auto-completion
if [[ "$-" == *i* ]]; then
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.bash" 2>/dev/null
fi

# key bindings
source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.bash"

# colors
if [[ "${FZF_DEFAULT_OPTS}" != *color* ]]; then
  FZF_DEFAULT_OPTS+=(
    "--color=fg:#888888,hl:#b030a0"
    "--color=fg+:#bbbbbb,bg+:#151a1e,hl+:#36a3d9"
    "--color=info:#508040,prompt:#8030e0,pointer:#f06722"
    "--color=marker:#0040bb,spinner:#b02828,header:#0078c8"
  )
  export FZF_DEFAULT_OPTS
fi

# default commands
if hash fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND="command fd -HIi --type file"
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi
