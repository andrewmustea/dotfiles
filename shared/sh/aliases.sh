# shellcheck shell=bash
# shellcheck disable=SC2139

#
# sh/aliases.sh
#

# cargo
alias cargo-update='cargo install-update --all'

# dmesg
if [[ "$(uname)" != "Darwin" ]]; then
  alias dmesg='dmesg --color'
fi

# diff
alias diffdir='diff -qr'

# dir
if command -v dir &>/dev/null; then
  alias dir='dir --color=auto'
fi

# grep
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# homebrew
alias bu='brew update ; brew upgrade -g -y ; brew cleanup -s'

# ls
if command ls --color=auto &>/dev/null; then
  alias ls='ls -Fh --color=auto'
  alias ll='ls -Fhl --color=auto'
  alias la='ls -AFhl --color=auto'
  alias l='ls -CFh --color=auto'
else
  alias ls='ls -FhG'
  alias ll='ls -FhlG'
  alias la='ls -AFhlG'
  alias l='ls -CFhG'
fi

# markdownlint
if ! command -v markdownlint &>/dev/null && command -v markdownlint-cli2 &>/dev/null; then
  alias markdownlint='markdownlint-cli2'
fi

# mkdir
alias mkdir='mkdir -p'

# nvim
alias {vi,nvi}='nvim'
alias {vd,nvd,nvimdiff}='nvim -d'
alias {vo,vv}='nvim -O'
alias nvim-remove-swap='rm -rf "${XDG_STATE_HOME}/nvim/swap/"*'

# ohmyzsh
if [[ -n "${ZSH_VERSION}" ]]; then
  alias ou='omz update'
fi

# permissions
alias mx='chmod a+x'

# python
alias python='python3'
alias {pip,pip3}='python3 -m pip'
alias venv='python3 -m venv'

# ripgrep
alias rga='rg --no-ignore --no-ignore-files --hidden'

# rsync
alias rsync-copy='rsync -avzhP'
alias rsync-move='rsync -avzhP --remove-source-files'
alias rsync-update='rsync -avzhPu'
alias rsync-sync='rsync -avzhPu --delete'

# sudo
alias sudo='sudo --preserve-env '

# tcp/ip
alias pingpath='mtr'
alias myip='curl -s checkip.amazonaws.com'
alias net='ifconfig | grep "inet "'

# wget
alias wget='wget --hsts-file="${XDG_DATA_HOME}/wget-hsts"'
