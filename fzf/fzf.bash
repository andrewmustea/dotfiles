#!/bin/bash

#
# ~/.config/fzf/fzf.bash
#

# XDG directory
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# add fzf to path
if [[ ":${PATH}:" != ":${XDG_DATA_HOME}/fzf/bin:" ]]; then
  export PATH="${XDG_DATA_HOME}/fzf/bin${PATH:+":${PATH}"}"
fi

# auto-completion
if [[ "$-" == *i* ]]; then
  source "${XDG_DATA_HOME}/fzf/shell/completion.bash" 2> /dev/null
fi

# key bindings
source "${XDG_DATA_HOME}/fzf/shell/key-bindings.bash"

# colors
if [[ "${FZF_DEFAULT_OPTS}" != *color* ]]; then
  OPTS=("--color=fg:#888888,hl:#b030a0"
        "--color=fg+:#bbbbbb,bg+:#151a1e,hl+:#36a3d9"
        "--color=info:#508040,prompt:#8030e0,pointer:#f06722"
        "--color=marker:#0040bb,spinner:#b02828,header:#0078c8")
  export FZF_DEFAULT_OPTS+=" ${OPTS[*]}"
fi

