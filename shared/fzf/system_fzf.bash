#!/bin/bash

#
# ~/.config/fzf/fzf.bash
#

# check if fzf is available
if ! hash fzf &>/dev/null; then
  echo "fzf not found" 1>&2
  return 1
fi

# check if system fzf install exists
if [[ ! -d /usr/share/fzf ]]; then
  echo "couldn't find system fzf directory at '/usr/share/fzf'" 1>&2
  return 1
fi

# auto-completion
if [[ "$-" == *i* ]]; then
  source "/usr/share/fzf/completion.bash" 2>/dev/null
fi

# key bindings
source "/usr/share/fzf/key-bindings.bash"

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
