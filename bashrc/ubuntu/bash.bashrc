# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *)   return;;
esac

# term
TTY=$(tty)
export GPG_TTY=$TTY

# shell options
shopt -s checkwinsize
shopt -s histappend
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# history
PROMPT_COMMAND="history -a"
HISTSIZE=1000
HISTFILESIZE=2000

# rust binaries
rust_env="$HOME/.cargo/env"
if [ -f "rust_env" ]; then
    . "$rust_env"
fi

# use aliases with sudo and refresh when used
alias sudo="sudo -v; sudo --preserve-env "

# ls aliases
alias ls="ls -hF --color=auto"
alias ll="ls -l"
alias la="ls -Al"
alias l="ls -C"

# mkdir
alias mkdir="mkdir --parents"

# vim & nvim
export EDITOR="nvim"
alias vi="nvim"
alias nvi="nvim"
alias nvimdiff="nvim -d"

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

# git
alias gs="git status"
alias gp="git pull"
alias gst="git stash"
alias gd="git difftool"
alias gf="git fetch --all"
alias gc="git commit"
alias gca="git commit --amend"
alias ga="git add"
alias gb="git branch"

get_branch() {
    local branch_name
    branch_name="$(git symbolic-ref HEAD)"
    branch_name=${branch_name##refs/heads/}
    echo "$branch_name"
}

update_branch() {
    local branch_name
    branch_name=$(get_branch)
    if [ -z "$branch_name" ]; then
        return 1
    fi

    if [ "$1" = "$branch_name" ]; then
        git pull
    else
        printf "Temporarily checking out %s\n" "$1"
        git checkout "$1"
        git pull
        printf "\nChecking back out %s\n" "$branch_name"
        git checkout "$branch_name"
    fi
}

update_master() {
    if [ -z "$(get_branch)" ]; then
        return 1
    fi

    local master
    if [ $# -eq 0 ]; then
        echo "No master branch given."
        read -r -p "Default to branch \"master\"? [y/N] " response
        case "$response" in
            [yY][eE][sS]|[yY])
                master="master"
                ;;
            *)
                return 1
                ;;
        esac
    elif [ $# -eq 1 ]; then
        if git show-ref -q --heads "$1"; then
            master=$1
        else
            printf "%s branch does not exist locally.\n" "$1"
            return 1
        fi
    else
        echo "Incorrect number of arguments."
        echo "Usage: update_master [master branch name]"
        return 1
    fi

    if [ "$(git status --porcelain | wc -l)" -eq "1" ]; then
        echo "Changes detected. Temporarily stashing them..."
        git stash save --include-untracked "Temporary $master update stash"
        update_branch "$master"
        echo "Reapplying temporary stash..."
        git stash pop
    else
        update_branch "$master"
    fi
}

# checkpatch
alias ckp="./scripts/checkpatch.pl -g"

# chmod and permissions commands
alias mx='chmod a+x'

# other functions
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



# Ubuntu

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
# but only if not SUDOing and have SUDO_PS1 set; then assume smart user.
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
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

