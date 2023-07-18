#!/bin/zsh

#
# ohmyzsh/custom/themes/black_sun.zsh-theme
#

git_branch_status() {
  local cb="$(git_current_branch)"
  if [[ -n "${cb}" ]]; then
    echo "%{$fg[green]%}[$cb]"
  fi
}

PROMPT='%{$fg[cyan]%}[%~% ]$(git_branch_status)%{$reset_color%}$ '

