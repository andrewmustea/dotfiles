# shellcheck shell=bash

#
# git/git-functions.sh
#

# print the branch name of the current directory or a given one
git-current-branch() {
  local dir="${PWD}"
  if (($# > 1)); then
    echo "error: too many arguments: $*" 1>&2
    echo "usage: ${FUNCNAME:-$0} [branch]" 1>&2
    return 1
  elif (($# == 1)); then
    dir="$1"
  fi

  git -C "${dir}" rev-parse --abbrev-ref HEAD
}

# run an interactive rebase starting at a given commit
rebase-at-commit() {
  if (($# == 0)); then
    echo "error: missing commit-id" 1>&2
    echo "usage: ${FUNCNAME:-$0} <commit-id>" 1>&2
    return 1
  elif (($# > 1)); then
    echo "error: too many arguments: $*" 1>&2
    echo "usage: ${FUNCNAME:-$0} <commit-id>" 1>&2
    return 1
  fi

  git rebase --interactive "${1}^"
}

# rebase a branch on a given remote without having to manually stash any changes
rebase-remote() {
  if (($# == 0)); then
    echo "error: need remote name" 1>&2
    echo "usage: ${FUNCNAME:-$0} <remote> [branch]" 1>&2
  fi

  local current_branch
  current_branch="$(git-current-branch "$2")"
  if [[ -z "${current_branch}" ]]; then
    return 1
  fi

  local branch="master"
  if (($# == 1)); then
    branch="$2"
  fi

  git fetch --all
  git rebase "$1/${branch}" "${branch}"

  if [[ "${current_branch}" != "${branch}" ]]; then
    git checkout "${current_branch}"
  fi
}

# add a pattern to .git/info/exclude
add-exclude() {
  local repo="${PWD}"
  if (($# == 0)); then
    echo "error: missing exclude argument" 1>&2
    echo "usage: ${FUNCNAME:-$0} <exclude-type> [directory]" 1>&2
    return 1
  elif (($# > 2)); then
    echo "error: too many arguments: $*" 1>&2
    echo "usage: ${FUNCNAME:-$0} <exclude-type> [directory]" 1>&2
    return 1
  elif (($# == 2)); then
    repo="$2"
  fi

  local exclude="${repo}/.git/info/exclude"
  if [[ ! -f "${exclude}" ]]; then
    echo "error: git exclude file not found: '${exclude}'" 1>&2
    return 1
  fi

  if ! grep -q "$(printf '^%q$' "$1")" "${exclude}"; then
    echo "adding '$1' to '${exclude}'"
    echo "$1" >>"${exclude}"
  else
    echo "'$1' already exists in '${exclude}'" 1>&2
  fi
}

# add '.vscode*' to .git/info/exclude
add-exclude-vscode() {
  local repo="${PWD}"
  if (($# > 1)); then
    echo "error: too many arguments" 1>&2
    echo "usage: ${FUNCNAME:-$0} [repository]" 1>&2
    return 1
  elif (($# == 1)); then
    repo="$1"
  fi
  add-exclude ".vscode*" "${repo}"
}

# run a diff against the same branch on a remote
diff-remote() {
  if (($# == 0)); then
    echo "error: missing remote name" 1>&2
    echo "usage: ${FUNCNAME:-$0} <remote> [diff args]" 1>&2
    return 1
  fi

  if ! git remote | grep -q "$1"; then
    echo "error: unknown remote '$1'" 1>&2
    return 1
  fi

  git diff "${1}/$(git-current-branch)" "${@:2}"
}

# run difftool against the same branch on a remote
difftool-remote() {
  if (($# == 0)); then
    echo "error: missing remote name" 1>&2
    echo "usage: ${FUNCNAME:-$0} <remote> [difftool args]" 1>&2
    return 1
  fi

  if ! git remote | grep -q "$1"; then
    echo "error: unknown remote '$1'" 1>&2
    return 1
  fi

  git difftool "${1}/$(git-current-branch)" "${@:2}"
}
