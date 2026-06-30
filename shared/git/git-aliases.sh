# shellcheck shell=bash
# shellcheck disable=SC2139

#
# git/git-aliases.sh
#

# status
alias gs='git status'
alias gss='git status --short'

# fetch
alias gf='git fetch'
alias gfa='git fetch --all'

# log
alias gl='git log'
alias glp='git log --patch'

# show
alias gsh='git show'
alias gshn='git show --name-only'
alias {gshm,git-show-message}='git log -1 --pretty=%B'
alias {gsht,git-show-title}='git show -s --format=%s'

# branch
alias gb='git branch'
alias gba='git branch -a'
alias gcb='git-current-branch'

# pull
alias gp='git pull'
alias gpr='git pull --rebase'

# add
alias ga='git add'
alias gaa='git add .'

# commit
alias gc='git commit'
alias gca='git commit --amend'

# stash
alias gst='git stash'
alias gsti='git stash --include-untracked'
alias gsta='git stash apply'

# diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdh='git diff HEAD'

# difftool
alias gdt='git difftool'
alias gdts='git difftool --staged'
alias gdth='git difftool HEAD'

# mergetool
alias gmt='git mergetool'

# remote
alias gr='git remote'
alias grv='git remote -v'

# rebase-remote
alias rebase-origin='rebase-remote origin'
alias rebase-upstream='rebase-remote upstream'

# diff-remote
alias diff-origin='diff-remote origin'
alias diff-upstream='diff-remote upstream'
alias difftool-origin='difftool-remote origin'
alias difftool-upstream='difftool-remote upstream'

# other custom functions
alias rbc='rebase-at-commit'
