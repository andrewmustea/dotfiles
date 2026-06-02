#!/bin/zsh

#
# ohmyzsh/custom/themes/black_sun.zsh-theme
#

_cursor_fix() {
  printf '\e[5 q'
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _cursor_fix

virtualenv_info() {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo "(${VIRTUAL_ENV:t}) "
  fi
}

git_branch_status() {
  local cb="$(git_current_branch)"
  if [[ -n "${cb}" ]]; then
    echo "%{$fg[green]%}[$cb]"
  fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PROMPT='$(virtualenv_info)%{$fg[cyan]%}[%~]$(git_branch_status)%{$reset_color%}$ '

