#!/usr/bin/env bash

# Setup fzf
# ---------
if [[ "$PATH" != *$HOME/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"

# Colors
# ------
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --color=fg:#888888,bg:#0c0c0c,hl:#b030a0 \
    --color=fg+:#bbbbbb,bg+:#151a1e,hl+:#36a3d9 \
    --color=info:#508040,prompt:#8030e0,pointer:#f06722 \
    --color=marker:#0040bb,spinner:#b02828,header:#0078c8"
export FZF_DEFAULT_OPTS

