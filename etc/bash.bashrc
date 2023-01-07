#!/bin/bash

#
# /etc/bash.bashrc
#

# return if not running interactively
case "$-" in
  *i*) ;;
  *) return ;;
esac

# --------------------------------------------------
# bash settings
# --------------------------------------------------

# bash colors
export GREEN="\[\033[0;32m\]"
export CYAN="\[\033[0;36m\]"
export RED="\[\033[0;31m\]"
export PURPLE="\[\033[0;35m\]"
export BROWN="\[\033[0;33m\]"
export LIGHT_GRAY="\[\033[0;37m\]"
export LIGHT_BLUE="\[\033[1;34m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_CYAN="\[\033[1;36m\]"
export LIGHT_RED="\[\033[1;31m\]"
export LIGHT_PURPLE="\[\033[1;35m\]"
export YELLOW="\[\033[1;33m\]"
export WHITE="\[\033[1;37m\]"
export RESTORE="\[\033[0m\]" #0m restores to the terminal's default color

# terminal prompt
if [[ "${TERM}" == +(xterm-color|*-256color) ]] ||
  grep -q "^${TERM}\$" <<< "$(dircolors -p)"; then
  if [[ "$(id -u)" -eq 0 ]]; then
    PS1="${LIGHT_RED}\u@\h${LIGHT_GRAY}:${LIGHT_BLUE}\w${LIGHT_GRAY}# "
  else
    PS1="${LIGHT_GREEN}\\u@\\h${LIGHT_GRAY}:${LIGHT_BLUE}\\w${LIGHT_GRAY}\\\$ "
  fi
else
  PS1='\u@\h:\w\$ '
fi

PS2="> "
PS3="> "
PS4="+ "

# title
case "${TERM}" in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND="${PROMPT_COMMAND:+"${PROMPT_COMMAND}; "}"'printf \
      "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#"${HOME}"/"~"}"'

    ;;
  screen*)
    PROMPT_COMMAND="${PROMPT_COMMAND:+"${PROMPT_COMMAND}; "}"'printf \
      "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#"${HOME}"/"~"}"'
    ;;
esac

# shopt
shopt -s autocd cdspell checkhash checkjobs checkwinsize cmdhist dirspell \
         dotglob expand_aliases extglob extquote globstar histappend \
         interactive_comments no_empty_cmd_completion progcomp promptvars \
         sourcepath xpg_echo

# bash_completion
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  else
    echo "bash_completion not found"
  fi
fi

# command-not-found
command_not_found_handle() {
  # check because c-n-f could've been removed in the meantime
  if [[ -x /usr/lib/command-not-found ]]; then
    /usr/lib/command-not-found -- "$1"
    return "$?"
  elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
    /usr/share/command-not-found/command-not-found -- "$1"
    return "$?"
  else
    printf "%s: command not found\n" "$1" >&2
    return 127
  fi
}

# bash history
export HISTCONTROL=ignoredups
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export HISTFILESIZE=100000
export HISTIGNORE='history:pwd:ls:ll:la:l:dir:'
export HISTSIZE=100000
export HISTTIMEFORMAT='%F %T '

if [[ "${PROMPT_COMMAND}" != *"history -a"* ]]; then
  export PROMPT_COMMAND="history -a${PROMPT_COMMAND:+"; ${PROMPT_COMMAND}"}"
fi

# --------------------------------------------------
# aliases
# --------------------------------------------------

# btm
alias bot='btm'

# cargo
alias cargo-update='cargo install-update --all'

# colors
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color'

# diff
alias diffdir='diff -qr'

# less
alias less='less -QR'
alias man='man -P "less -QR"'

# ls
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias l='ls -C'

# mkdir
alias mkdir='mkdir --parents'

# nvim
hash vim &>/dev/null || alias vim='nvim'
alias {vi,nvi}='nvim'
alias {vd,nvd,nvimdiff}='nvim -d'
alias nvim-remove-swap='rm -rf "${XDG_STATE_HOME}/nvim/swap/*"'

# permissions
alias mx='chmod a+x'

# python
alias {pip,pip3}='python3 -m pip'
alias venv='python3 -m venv'

# sudo
alias sudo='sudo -v; sudo --preserve-env '

# tcp/ip
alias pingpath='mtr'
alias myip='curl -s checkip.amazonaws.com'

# wget
alias wget='wget --hsts-file="${XDG_DATA_HOME}/wget-hsts"'

