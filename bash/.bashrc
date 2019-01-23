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
PS1="\[\033[38;5;081m\]\u\[\033[38;5;245m\]@\[\033[38;5;206m\]\H \[\033[38;5;245m\]\w \[\033[38;5;081m\]$ \[\e[0m\]"

# Load alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# turn of unix'y suspend/resume stuff
stty -ixon

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

##############################################################################
# ENV variables
##############################################################################

# default editor.
export EDITOR=vi

# fzf is fuzzy finder - the env is used to tell it use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

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

# make predictable SSH authentication socket location.
# Old way
#MYSOCK="/tmp/ssh-agent-$USER-link"
# if [ -S $SSH_AUTH_SOCK ] && [ "$SSH_AUTH_SOCK" != $MYSOCK ]; then
# if [ -e $MYSOCK ]; then
# rm -f $MYSOCK
# fi
# ln -sf $SSH_AUTH_SOCK $MYSOCK
# export SSH_AUTH_SOCK=$MYSOCK
# fi
# New way - using systemd
export SSH_AUTH_SOCK="/run/user/$UID/ssh-agent.socket"
