.files
======

Here is a repo containing my dot files.

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

Bootstrap (madeofblue)
----------------------

`bootstrap` sets up a fresh [madeofblue](https://github.com/bugthing/madeofblue) install in one run: stow, Syncthing paired by QR code from the phone, Homebrew, mise and Neovim plugins, then links the synced folders (`~/.ssh`, `~/.password-store`, ...) into `$HOME`. Settings are in `bootstrap.conf`; details are at the top of the script.

    $ curl -fsSL https://raw.githubusercontent.com/bugthing/dotfiles/main/bootstrap | bash
