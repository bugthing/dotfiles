.files
======

Here is a repo containing my dot files.

Bootstrap a new machine
-----------------------

On a fresh [madeofblue](https://github.com/bugthing/madeofblue) (or any Bluefin) install:

    $ curl -fsSL https://raw.githubusercontent.com/bugthing/dotfiles/main/bootstrap | bash

In one run, this:

1. clones this repo to `~/.dotfiles` over HTTPS,
2. installs `bash/.brewfile` with Homebrew,
3. stows the packages listed in `bootstrap.conf` (per-file links; files in the way are moved to `<name>.pre-bootstrap-<timestamp>`),
4. starts the Syncthing quadlet and shows this machine's device ID as a QR code. In the Syncthing app on the phone, add a device by scanning it and share `HomeSync` and `PasswordStore` with it.
5. asks in the terminal before accepting the phone (as an introducer, auto-accepting its folders), then waits until the folders have synced,
6. links synced folders into `$HOME` (`~/.ssh`, `~/.gnupg`, `~/.password-store`, ...),
7. switches the repo remote to SSH.

It is safe to re-run. `SKIP_BREW=1` skips Homebrew; `SKIP_SYNC=1` skips Syncthing and links only what is already there.
Quadlets live in the `containers` package; `syncthing` is started by the bootstrap, the rest start at next login.

I use the gnu tool `stow` to manage them. Or the bash script included

Install stow
------------

    $ pacman -S stow
or

    $ apt install stow

Use script
------------

    $ ~/.dotfiles/stowsh ~/.dotfiles/bash

Setup
-----

Clone into directory `~/.dotfiles`, like so:

    $ cd ~
    $ git clone git@github.com:bugthing/dotfiles.git .dotfiles

Manage
------

To create the file system links for the different groups of dotfiles, use stow like so:

    $ cd ~/dotfiles
    $ stow bash
    $ stow vim
    $ stow tmux
    $ stow desktop
    $ stow containers
    $ stow ruby


System D
--------

There are some user systemd files include in my dotfile repo.
To enable/start them, do this:

    $ systemctl --user enable ssh-agent
    $ systemctl --user start ssh-agent


