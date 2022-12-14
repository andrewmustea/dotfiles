# dotfiles

Configs, dotfiles, and scripts I use to set up my linux environment.

Download the git submodules.

```bash
git submodule update --init --recursive
```

## [bat/](bat/)

[bat](https://github.com/sharkdp/bat/) is a clone of the shell command `cat`
built using [rust](https://www.rust-lang.org/).

This config uses the color scheme
[black_sun.tm](https://github.com/andrewmustea/black_sun.tm/) as a submodule.

To configure, place the [`bat/`](bat/) directory in `$XDG_CONFIG_HOME` or
`$HOME/.config/` and run:

```bash
bat cache --build
```

## [etc/](etc/)

Collection of configs and scripts that belong in the linux `/etc/` directory.

All files in [`etc/`](etc/) follow the same paths as `/etc/`.

### [etc/arch_environment](etc/arch_environment)

System wide environment variable settings file for Arch Linux.

> Rename to `environment` before placing in `/etc/`

### [etc/bash.bashrc](etc/bash.bashrc)

System wide `bashrc` file.

### [etc/environment](etc/environment)

System wide environment variable settings file for Ubuntu/Debian.

### [etc/profile](etc/profile)

System wide environment script sourced on interactive login shells.

### [etc/wsl.conf](etc/wsl.conf)

[Windows Subsystem for Linux (WSL)](https://aka.ms/wsl/) config file.

### [etc/profile.d/](etc/profile.d/)

Directory of extra shell scripts sourced by `etc/profile`.

> You only need to copy scripts in this directory as needed.

### [etc/sudoers.d/](etc/sudoers.d/)

Directory of extra shell scripts sourced by `/etc/sudoers`.

> Placing configs in `/etc/sudoers.d/` prevent's `sudo` from possibly failing
by ignoring any broken files.

## [fzf/](fzf/)

[`fzf`](https://github.com/junegunn/fzf/) is a command line fuzzy finder used
to filter lists, files, command history, processes, hostnames, bookmarks, or
git commits.

Place this directory in your `$XDG_CONFIG_HOME` or `$HOME/.config/`.

- Source [`fzf.bash`](fzf/system-fzf.bash) you have the fzf git repoisitory
- installed in `$XDG_DATA_HOME/fzf` or `$HOME/.local/share/fzf`.

- Source [`system-fzf.bash`](fzf/system-fzf.bash) if fzf is installed system wide.

## [`git/`](git/)

Config files used by [`git`](https://git-scm.com/).

Place this directory in your `$XDG_CONFIG_HOME` or `$HOME/.config/`.

## [`gitui/`](gitui/)

[`gitui`](https://github.com/extrawurst/gitui/) is a fast, lightweight,
terminal-based git GUI built using [`rust`](https://rust-lang.org/).

Place this directory in your `$XDG_CONFIG_HOME` or `$HOME/.config`.

## [`gnome/`](gnome/)

Contains a copy of my [gnome extensions](https://extensions.gnome.org/) configuration.

## [`gtk-3.0/`](gtk-3.0/) and [`gtk-4.0/`](gtk-4.0/)

Config file used for GTK-3.0 and GTK-4.0 applications respectively.

Place these directories in your `$XDG_CONFIG_HOME` or `$HOME/.config`.

## [`home/`](home/)

Dotfiles that belong in a user's `$HOME` directory.

### [`home/bash_logout`](home/bash_logout)

Script that is sourced when exiting from an interactive login bash shell.

> Rename to `.bash_logout` before placing in `$HOME`.

### [`home/bash_profile`](home/bash_profile)

Script that is sourced when entering an interactive login bash shell.

> Rename to `.bash_profile` before placing in `$HOME`.

### [`home/bashrc`](home/bashrc)

Script that is sourced when entering a bash shell.

> Rename to `.bashrc` before pacing in `$HOME`.

## [`npm/`](npm/)

[`npm`](https://www.npmjs.com/) is a command line software registry tool used
to install [`node.js`](https://nodejs.org/en/) packages.

Place this directory in your `$XDG_CONFIG_HOME` or `$HOME/.config`.

## [`nvim/`](nvim/)

[`neovim`](https://neovim.io/) is a terminal-based text editor that adds
significant improvements to the original Vim editor.

Place this directory in your `$XDG_CONFIG_HOME` or `$HOME/.config`.

Neovim plugins are provided by
[`packer.nvim`](https://github.com/wbthomason/packer.nvim/), which is
installed by running:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Create an nvim `state` directory by running:

```bash
mkdir --parents "${XDG_STATE_HOME}/nvim"
```

## [`root/`](root/)

Dotfiles that belong in the `/root/` directory

### [`root/bashrc`](root/)

Script that is sourced when entering a bash shell as `root`.

> Rename to `.bashrc` before pacing in `/root/`.

## [`setup/`](setup/)

Directory containing shell scripts to install common tools.

### [`setup/azure.sh`](setup/azure.sh)

Script that installs the [`azure-cli`](https://aka.ms/azure-cli/) command line tool.

> Requires `root` permissions.

### [`setup/fzf.sh`](setup/fzf.sh)

Script that installs the [`fzf`](https://github.com/junegunn/fzf/) command line
fuzzy finder.

> Requires `root` permissions if installing on Arch Linux.

### [`setup/go.sh`](setup/go.sh)

Script that installs the latest version of [`go`](https://go.dev/).

> Requires `root` permissions.

### [`setup/haskell.sh`](setup/haskell.sh)

On Ubuntu, this script installs the latest versions of
[`ghc`](https://www.haskell.org/ghc/),
[`cabal`](https://www.haskell.org/cabal/),
[`stack`](https://docs.haskellstack.org/en/stable/),
and [`shellcheck`](https://www.shellcheck.net/).

On Arch Linux, this script installs the latest versions of
[`ghc`](https://www.haskell.org/ghc/) and [`shellcheck`](https://www.shellcheck.net/).

> Requires `root` permissions if installing on Arch Linux.

### [`setup/lua-lsp.sh`](setup/lua-lsp.sh)

Script that installs the latest version of [`lua-language-server`](https://github.com/sumneko/lua-language-server).

> Requires `root` permissions if installing on Arch Linux.

### [`setup/nala.sh`](setup/nala.sh)

Script that installs the [`nala`](https://gitlab.com/volian/nala) command line
tool for Debian's `apt` package manager.

> Requires `root` permissions.

### [`setup/nvm.sh`](https://github.com/nvm-sh/nvm/)

Script that installs the [`nvm`](https://github.com/nvm-sh/nvm) version manager
for [`node-js`](https://nodejs.org/en/).

> Requires `root` permissions if installing on Arch Linux.

### [`setup/rust.sh`](setup/rust.sh)

Script that installs [`rust`](https://www.rust-lang.org/) and several other
rust command line programs.

- [`as-tree`](https://github.com/jez/as-tree/)
- [`bat`](https://github.com/sharkdp/bat/)
- [`bottom`](https://github.com/ClementTsang/bottom/)
- [`cargo`](https://doc.rust-lang.org/cargo/)
- [`cargo-fix`](https://doc.rust-lang.org/cargo/commands/cargo-fix.html/)
- [`cargo-update`](https://github.com/nabijaczleweli/cargo-update/)
- [`delta`](https://github.com/dandavison/delta/)
- [`dust`](https://github.com/bootandy/dust/)
- [`exa`](https://github.com/ogham/exa/)
- [`find`](https://github.com/sharkdp/fd/)
- [`gitui`](https://github.com/extrawurst/gitui/)
- [`git-gone`](https://github.com/swsnr/git-gone/)
- [`hck`](https://github.com/sstadick/hck)
- [`hx`](https://github.com/sitkevij/hex/)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep/)
- [`rm-improved`](https://github.com/nivekuil/rip/)
- [`sd`](https://github.com/chmln/sd/)
- [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md)
- [`viu`](https://github.com/atanunq/viu/)

> Requires `root` permissions if installing on Arch Linux.

## [`check-configs.sh`](check-configs.sh)

Script that compares the currently installed user configs against this
repository.

## [`install-programs.sh`](install-programs.sh)

Script that installs a number of configs, settings, and programs.

> Requires `root` permissions.

