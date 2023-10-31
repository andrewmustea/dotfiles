# macos

Configs I use to set up my macOS environment

## [etc/](etc/)

Collection of configs and scripts that belong in the `/etc/` directory.

All files in [`etc/`](etc/) follow the same paths as `/etc/`.

### [etc/zshenv](etc/zshenv)

System wide Zsh config file.

## [fzf/](fzf/)

[`fzf`](https://github.com/junegunn/fzf/) is a command line fuzzy finder used to filter lists, files, command history, processes, hostnames, bookmarks, or git commits.

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config/`.

## [`git/`](git/)

Config files used by [`git`](https://git-scm.com/).

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config/`.

## [`karabiner`](karabiner/)

[Karabiner-Elements](https://karabiner-elements.pqrs.org/) is a keyboard customizer for macOS.

Place this directory in your `${XDG_CONFIG_HOME}` or `${HOME}/.config/`.

### [`karabiner/assets/complex_modifications/amustea_shortcuts.json`](karabiner/assets/complex_modifications/amustea_shortcuts.json)

My complex modifications for Karabiner-Elements.

## [`zsh`](zsh/)

[`zsh`](https://zsh.org/) is a command line shell designed for interactive use and is default shell for macOS.

### [`zsh/zprofile`](zsh/zprofile)

Script that's sourced when entering an interactive login zsh shell.

> Rename to `.zprofile` before placing in `${ZDOTDIR}` or `${HOME}`.

### [`zsh/zshrc`](zsh/zshrc)

Script that's sourced when entering a zsh shell.

> Rename to `.zshrc` before placing in `${ZDOTDIR}` or `${HOME}`.
