.files
======

Here is a repo containing my dot files.

I use the gnu tool `stow` to manage them.

Install stow
------------

    $ pacman -S stow
or

    $ apt install stow

Setup
-----

Clone into directory `~/dotfiles`, like so:

    $ cd ~
    $ git clone git@github.com:bugthing/dotfiles.git

Manage
------

To create the file system links for the different groups of dotfiles, use stow like so:

    $ cd ~/dotfiles
    $ stow bash
    $ stow vim
    $ stow tmux
    $ stow desktop
    $ stow ruby

