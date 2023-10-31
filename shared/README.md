# shared

Configs and scripts I use that are shared between unix environments.

## [`bat/`](bat/)

[bat](https://github.com/sharkdp/bat/) is a clone of the shell command `cat` built using [rust](https://www.rust-lang.org/).

This config uses the color scheme [black_sun.tm](https://github.com/andrewmustea/black_sun.tm/) as a submodule.

To configure, place the [`bat/`](bat/) directory in `${XDG_CONFIG_HOME}` or `${HOME}/.config/` and run:

```bash
bat cache --build
```

## [`colorschemes/`](colorschemes/)

Collection of custom colorschemes.

## [`etc/`](etc/)

Collection of configs and scripts that belong in the unix `/etc/` directory.

All files in [`etc/`](etc/) follow the same paths as `/etc/`.

### [`etc/profile.d/`](etc/profile.d/)

Directory of extra shell scripts that can be sourced by `/etc/profile`.

### [`etc/wsl.conf`](etc/wsl.conf)

[Windows Subsystem for Linux (WSL)](https://aka.ms/wsl/) config file.

## [`flatpak/`](flatpak/)

Config files used by [`flakpak`](https://www.flatpak.org/) or programs installed with `flatpak`.

## [`fzf/`](fzf/)

[`fzf`](https://github.com/junegunn/fzf/) is a command line fuzzy finder used to filter lists, files, command history, processes, hostnames, bookmarks, or git commits.

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config/`.

## [`git/`](git/)

Config files used by [`git`](https://git-scm.com/).

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config/`.

## [`gitui/`](gitui/)

[`gitui`](https://github.com/extrawurst/gitui/) is a fast, lightweight, terminal-based git GUI built using [`rust`](https://rust-lang.org/).

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config`.

## [`gtk-3.0/`](gtk-3.0/) and [`gtk-4.0/`](gtk-4.0/)

Config file used for GTK-3.0 and GTK-4.0 applications respectively.

Place these directories in your `${XDG_CONFIG_HOME}` or `${HOME}/.config`.

## [`home/`](home/)

Configs that belong in a user's `${HOME}` directory.

### [`home/bash_logout`](home/bash_logout)

Script that's sourced when exiting from an interactive bash shell.

> Rename to `.bash_logout` before placing in `${HOME}`.

## [`npm/`](npm/)

[`npm`](https://www.npmjs.com/) is a command line software registry tool used to install [`node.js`](https://nodejs.org/en/) packages.

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config`.

## [`nvim/`](nvim/)

[`neovim`](https://neovim.io/) is a terminal-based text editor that adds significant improvements to the original Vim editor.

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config`.

Neovim plugins are provided by [`packer.nvim`](https://github.com/wbthomason/packer.nvim/), which is installed by running:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Create an nvim `state` directory by running:

```bash
mkdir --parents "${XDG_STATE_HOME}/nvim"
```

## [`ohmyzsh/`](ohmyzsh/)

Config files for the `zsh` plugin [`ohmyzsh`](https://github.com/ohmyzsh/ohmyzsh/).

### [`ohmyzsh/custom/themes/black_sun.zsh-theme`](ohmyzsh/custom/themes/black_sun.zsh-theme)

My custom dark theme.

## [`shellcheckrc`](shellcheckrc)

Config file for [`shellcheck`](https://www.shellcheck.net/).

Place this file in your `${XDG_CONFIG_HOME}` or `${HOME}/.config`.
