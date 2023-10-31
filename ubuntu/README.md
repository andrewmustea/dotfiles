# ubuntu

Configs I use to set up my Ubuntu environment

## [`etc/`](etc/)

Collection of configs and scripts that belong in the unix `/etc/` directory.

All files in [`etc/`](etc/) follow the same paths as `/etc/`.

### [`etc/bash.bashrc`](etc/bash.bashrc)

System wide `bashrc` file.

### [`etc/environment`](etc/environment)

System wide environment variable file.

### [`etc/profile`](etc/profile)

System wide script sourced on interactive login shells.

### [`etc/sudoers.d/`](etc/sudoers.d/)

Directory of extra shell scripts sourced by `/etc/sudoers`.

Placing configs in `/etc/sudoers.d/` prevents broken config files from breaking `sudo`.

#### [`etc/sudoers.d/disable_admin_successful`](etc/sudoers.d/disable_admin_successful)

Prevents `sudo` from creating a `.sudo_as_admin_successful` file in a user's `${HOME}` directory.

## [`home/`](home/)

Configs that belong in a user's `${HOME}` directory.

### [`home/bash_profile`](home/bash_profile)

Script that's sourced when entering an interactive login bash shell.

> Rename to `.bash_profile` before placing in `${HOME}`.

### [`home/bashrc`](home/bashrc)

Script that's sourced when entering a bash shell.

> Rename to `.bashrc` before pacing in `${HOME}`.

## [`root/`](root/)

Configs that belong in the `/root/` directory

### [`root/bashrc`](root/bashrc)

Script that's sourced when entering a bash shell.

> Rename to `.bashrc` before pacing in `/root/`.
