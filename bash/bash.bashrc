#!/bin/bash

#
# /etc/bash.bashrc
#


# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *)   return;;
esac


# terminal prompt
#
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

# check if we have a colors database file
colors_database=""
if [[ -f ~/.dir_colors ]]; then
    colors_database="${colors_database}$(cat ~/.dir_colors)"
elif [[ -f /etc/DIR_COLORS ]]; then
    colors_database="${colors_database}$(cat /etc/DIR_COLORS)"
fi

# if there are no colors files, then use dircolors default database
if [[ -z ${colors_database} ]] && type -P dircolors >/dev/null; then
    colors_database=$(dircolors --print-database)
fi

# apply bash prompt colors if available
term_type=${TERM//[^[:alnum:]]/?}
if [[ $term_type == +(xterm-color|*-256color) ]] || \
    [[ $'\n'${colors_database} == *$'\n'"TERM "${term_type}* ]]; then
    if type -P dircolors >/dev/null ; then
        if [ -f ~/.dir_colors ] ; then
            eval "$(dircolors -b ~/.dir_colors)"
        elif [ -f /etc/DIR_COLORS ] ; then
            eval "$(dircolors -b /etc/DIR_COLORS)"
        fi
    fi

    if [[ "$(id -u)" -eq 0 ]]; then
        PS1="$LIGHT_RED\u@\h"
    else
        PS1="$LIGHT_GREEN\u@\h"
    fi
    PS1+="$LIGHT_GRAY:$LIGHT_BLUE\w$LIGHT_GRAY\$ "
else
    PS1='\u@\h:\w\$ '
fi

PS2="> "
PS3="> "
PS4="+ "

case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen*)
        PS1="\[\e]0;${PROMPT_COMMAND:+($PROMPT_COMMAND)}\u@\h:\w\a\]$PS1"
        ;;
    *)
        ;;
esac

unset term_type colors_database


# shell options
#
shopt -s checkwinsize
shopt -s histappend
shopt -s extglob
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [ -x /usr/lib/command-not-found ] || \
[ -x /usr/share/command-not-found/command-not-found ]; then
    command_not_found_handle() {
	    # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
            /usr/lib/command-not-found -- "$1"
            return $?
        elif [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    }
fi


# history
#
PROMPT_COMMAND='history -a'
HISTSIZE=10000
HISTFILESIZE=10000
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='history:ls:pwd:'


# sudo
#
# refresh sudo and export environment
alias sudo='sudo -v; sudo --preserve-env '


# ls
#
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias l='ls -C'


# mkdir
#
alias mkdir='mkdir --parents'


# colors
#
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color'

GCC_COLORS="$(printf "error=01;31:warning=01;35:note=01;%s"\
    "36:caret=01;32:locus=01:quote=01")"
export GCC_COLORS


# nvim
#
export EDITOR='nvim'
alias {vi,nvi}='nvim'
alias {vd,nvd,nvimdiff}='nvim -d'
alias nvim_remove_swap='rm -rf ~/.local/share/nvim/swap/'


# less
LESS_TERMCAP_mb="$(printf '\E[01;31m')"
LESS_TERMCAP_md="$(printf '\E[01;38;5;74m')"
LESS_TERMCAP_me="$(printf '\E[0m')"
LESS_TERMCAP_se="$(printf '\E[0m')"
LESS_TERMCAP_so="$(printf '\E[38;5;246m')"
LESS_TERMCAP_ue="$(printf '\E[0m')"
LESS_TERMCAP_us="$(printf '\E[04;38;5;146m')"

export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_se
export LESS_TERMCAP_so
export LESS_TERMCAP_ue
export LESS_TERMCAP_us

alias less='less -Q'
alias man='man -P "less -Q"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# environments
#
fzf_env="$HOME/.fzf.bash"
[ -f "$fzf_env" ] && . "$fzf_env"

rust_env="$HOME/.cargo/env"
[ -f "$rust_env" ] && . "$rust_env"


# git
#
alias gs='git status'
alias gf='git fetch --all'
alias gp='git pull'
alias gst='git stash'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gca='git commit --amend'
alias gb='git branch'
alias gd='git diff'
alias gdt='git difftool'
alias gdh='git diff HEAD'
alias gdth='git difftool HEAD'
alias gmt='git mergetool'
alias rebase_origin='git fetch --all && git rebase origin/master master'
alias rebase_upstream='git fetch --all && git rebase upstream/master master'

get_branch_name() {
    local branch_name
    if [[ $# -gt 1 ]]; then
        echo 'Too many arguments'
        return 1
    elif [[ $# -eq 1 ]]; then
        branch_name="$(git -C "$1" symbolic-ref HEAD)"
    else
        branch_name="$(git symbolic-ref HEAD)"
    fi
    echo "${branch_name##refs/heads/}"
}


# ips and ssh targets
#
alias myip='curl -s checkip.amazonaws.com'


# permissions
#
alias mx='chmod a+x'


# other
#
psgrep() {
    pgrep "$@" | xargs --no-run-if-empty ps -fp
}

pskill() {
    local pid
    pid=$(pgrep "$@" | xargs -r ps --no-headers -fp | awk '{ print $2 }')
    printf "killing %s (process %s)...\n" "$1" "$pid"
    kill -9 "$pid"
}

extract () {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf "$1"    ;;
            *.tar.gz)    tar xvzf "$1"    ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xvf "$1"     ;;
            *.tbz2)      tar xvjf "$1"    ;;
            *.tgz)       tar xvzf "$1"    ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           printf "don't know how to extract '%s'...\n" "$1" ;;
        esac
    else
        printf "'%s' is not a valid file!\n" "$1"
    fi
}

