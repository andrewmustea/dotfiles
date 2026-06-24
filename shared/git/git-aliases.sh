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
alias {gshm,git-show-message}='git show -s'
alias {gsht,git-show-title}='git show -s --format=%s'

# branch
alias gb='git branch'
alias gba='git branch -a'
alias {gcb,git-current-branch}='git_current_branch'

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

# rebase_remote
alias rebase-remote='rebase_remote'
alias {rebase_origin,rebase-origin}='rebase_remote origin'
alias {rebase_upstream,rebase-upstream}='rebase_remote upstream'

# diff_remote
alias diff-remote='diff_remote'
alias difftool-remote='difftool_remote'
alias {diff_origin,diff-origin}='diff_remote origin'
alias {diff_upstream,diff-upstream}='diff_remote upstream'
alias {difftool_origin,difftool-origin}='difftool_remote origin'
alias {difftool_upstream,difftool-upstream}='difftool_remote upstream'

# other custom functions
alias {rbc,rebase-at-commit}='rebase_at_commit'
alias add-exclude='add_exclude'
alias add-exclude-vscode='add_exclude_vscode'
