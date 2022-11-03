#!/bin/bash

#
# /etc/bash.bashrc
#


# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac


# --------------------------------------------------
# terminal prompt settings
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

# use a colors file if it exists,
# otherwise use the dircolors default database
if [[ -f "$HOME/.dir_colors" ]]; then
    color_data="$(cat "$HOME/.dir_colors")"
    eval "$(dircolors -b "/etc/DIR_COLORS")"
elif [[ -f /etc/DIR_COLORS ]]; then
    color_data="$(cat "/etc/DIR_COLORS")"
    eval "$(dircolors -b "/etc/DIR_COLORS")"
else
    color_data="$(dircolors --print-database)"
fi

# apply bash prompt colors if available
if [[ "$TERM" == +(xterm-color|*-256color) ]] ||
    grep -q "^$TERM$" <<< "$color_data"; then
    if [[ "$(id -u)" -eq 0 ]]; then
        PS1="$LIGHT_RED\u@\h$LIGHT_GRAY:$LIGHT_BLUE\w$LIGHT_GRAY# "
    else
        PS1="$LIGHT_GREEN\u@\h$LIGHT_GRAY:$LIGHT_BLUE\w$LIGHT_GRAY\$ "
    fi
else
    PS1='\u@\h:\w\$ '
fi
unset color_data

PS2="> "
PS3="> "
PS4="+ "

case "$TERM" in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
        PS1="\[\e]0;${PROMPT_COMMAND:+($PROMPT_COMMAND)}\u@\h:\w\a\]$PS1"
        ;;
    screen*)
        PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf \
            "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        ;;
    *)
        ;;
esac


# shopt
#
shopt -s \
    autocd cdspell checkhash checkjobs checkwinsize cmdhist dirspell dotglob \
    expand_aliases extglob extquote globstar histappend interactive_comments \
    no_empty_cmd_completion progcomp promptvars sourcepath xpg_echo


# bash_completion
#
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
#
command_not_found_handle() {
    # check because c-n-f could've been removed in the meantime
    if [[ -x /usr/lib/command-not-found ]]; then
        /usr/lib/command-not-found -- "$1"
        return $?
    elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
        /usr/share/command-not-found/command-not-found -- "$1"
        return $?
    else
        printf "%s: command not found\n" "$1" >&2
        return 127
    fi
}


# sudo
#
alias sudo='sudo -v; sudo --preserve-env '


# --------------------------------------------------
# interactive bash settings
# --------------------------------------------------


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

GCC_COLORS="$(printf "error=01;31:warning=01;35:note=01;%s" \
    "36:caret=01;32:locus=01:quote=01")"
export GCC_COLORS


# diff
#
alias diffdir='diff -qr'


# nvim
#
export EDITOR='nvim'
! which vim &>/dev/null && alias vim='nvim'
alias {vi,nvi}='nvim'
alias {vd,nvd,nvimdiff}='nvim -d'
alias nvim-remove-swap='rm -rf "$XDG_DATA_HOME/nvim/swap/"'


# less
#
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

export LESSHISTFILE="$CACHE/less/history"
alias less='less -QR'
alias man='man -P "less -QR"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --------------------------------------------------
# other
# --------------------------------------------------


# print path
#
print-path() {
    printf "%s\n" "${PATH//:/$'\n'}"
}


# ips and ssh targets
#
alias pingpath='mtr'
alias myip='curl -s checkip.amazonaws.com'


# permissions
#
alias mx='chmod a+x'


# other functions
#
psgrep() {
    pgrep "$@" | xargs --no-run-if-empty ps -fp
}

pskill() {
    local pid
    pid=$(pgrep "$@" | xargs -r ps --no-headers -fp | awk '{ print $2 }')
    echo "killing $1 (process $pid)..."
    kill -9 "$pid"
}

extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2) tar xvjf "$1" ;;
            *.tar.gz) tar xvzf "$1" ;;
            *.tar.xz) tar xvf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xvf "$1" ;;
            *.tbz2) tar xvjf "$1" ;;
            *.tgz) tar xvzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

