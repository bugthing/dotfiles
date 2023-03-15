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

# autocomplete
if [ -f $HOME/.config/bash/git-completion.bash ]; then
  . $HOME/.config/bash/git-completion.bash
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# configure gpg agent stuff.
#   see: https://man.archlinux.org/man/gpg-agent.1
#   see: https://budts.be/weblog/2012/08/ssh-authentication-with-your-pgp-key/
GPG_TTY=$(tty)
export GPG_TTY
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  # set the ssh auth sock to be that from gpg-agent
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
# make predictable SSH authentication socket location.
MYSOCK="/tmp/ssh-agent-$USER-link"
if [ -S $SSH_AUTH_SOCK ] && [ "$SSH_AUTH_SOCK" != $MYSOCK ]; then
  if [ "$SSH_AUTH_SOCK" -ef "$MYSOCK" ]; then
    : # Already the same file
  else
    ln -sfn $SSH_AUTH_SOCK $MYSOCK
  fi
  export SSH_AUTH_SOCK=$MYSOCK
fi


##############################################################################
# Local programming langs
##############################################################################

# asdf - multiple language switcher
if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

# asdf java - set JAVA_HOME
if [ -f "$HOME/.asdf/plugins/java/set-java-home.sh" ]; then
  . $HOME/.asdf/plugins/java/set-java-home.sh
fi

# bash like history in iex (elixir)
export ERL_AFLAGS="-kernel shell_history enabled"

##############################################################################
# ENV variables
##############################################################################

# default editor.
export EDITOR=nvim

# fzf is fuzzy finder - here is my setup
if [ -f /usr/share/fzf/key-bindings.bash ]; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
  export FZF_TMUX_OPTS="-p"
  export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
  export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window 'up:3:hidden:wrap'
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
    --color 'header:italic'
    --header 'Press CTRL-Y to copy command into clipboard'
  "
  . /usr/share/fzf/key-bindings.bash
  . /usr/share/fzf/completion.bash
  bind -x '"\C-f":"vi $(fzf)"' # bind CTRL+f to search and open in nvim
fi

# cd also looks in home dir:
export CDPATH="$HOME:$CDPATH"

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

if [ -d "$HOME/dev/flutter" ]; then
  export PATH="$PATH:$HOME/dev/flutter/bin"
  export no_proxy=127.0.0.1
fi

if [ -f "$HOME/.asdf/plugins/java/set-java-home.bash" ]; then
  source "$HOME/.asdf/plugins/java/set-java-home.bash"
fi

##############################################################################
# Custom config
##############################################################################

if [ -f "$HOME/.bash_local" ]; then
  source $HOME/.bash_local
fi

