#
# ~/.bashrc
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

##############################################################################
# Setup Shell
##############################################################################

# bash history: ignoredups ignorespace or ignoreboth
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set my prompt
source ~/.bash_prompt

# Load alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# turn of unix'y suspend/resume stuff
stty -ixon

# auto change to dir (not need for cd)
shopt -s autocd

##############################################################################
# Local programming langs
##############################################################################

# asdf - multiple language switcher
if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

# bash like history is iex (elixir)
export ERL_AFLAGS="-kernel shell_history enabled"

if [ -f $HOME/.config/bash/git-completion.bash ]; then
  . $HOME/.config/bash/git-completion.bash
fi

##############################################################################
# ENV variables
##############################################################################

# default editor.
export EDITOR=vim

# fzf is fuzzy finder - the env is used to tell it use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# cd also looks in home dir:
export CDPATH="$HOME:$CDPATH"

export PATH="./node_modules/.bin:$PATH"

if [ -d "$HOME/build/bin" ]; then
  export PATH="$HOME/build/bin:$PATH"
fi
if [ -d "$HOME/scripts" ]; then
  export PATH="$HOME/scripts:$PATH"
fi
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin/" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "/var/lib/snapd/snap/bin" ]; then
  export PATH="/var/lib/snapd/snap/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -d "$HOME/go/bin" ]; then
  export PATH="$PATH:$HOME/go/bin"
fi

# Ensure tje agent is pointing at the right place
MYSOCK="/run/user/$UID/ssh-agent.socket"
if [ -S $SSH_AUTH_SOCK ] && [ "$SSH_AUTH_SOCK" != $MYSOCK ]; then
  ln -sf $SSH_AUTH_SOCK $MYSOCK
  export SSH_AUTH_SOCK=$MYSOCK
fi

