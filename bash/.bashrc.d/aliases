#===========================================================================
# Work
#===========================================================================

function redis-clearout-rails {
  bundle exec rails runner 'Sidekiq.redis { |conn| conn.flushdb }'
}

function redis-clearout-docker {
  docker exec redis redis-cli flushall
}

function dockerclean {
  docker rm `docker ps -aq`
  docker rmi `docker images -aq`
}

#===========================================================================
# Misc.
#===========================================================================

function ssl-check {
  domain=$1
  if [[ -z "${domain}" ]]; then
    echo 'Please provide a domain to check (e.g. $ ssl-check www.google.com)'
    return 1
  fi
  echo | openssl s_client -servername ${domain} -connect ${domain}:443 2>/dev/null | openssl x509 -noout -dates
}

function xo {
  gio open $*
}

function cpstat () {
 j tar c "$1" | pv | tar x -C "$2"
}

function run_prefered_vim () {
  if [ -x "$(command -v $HOME/Applications/nvim.appimage)" ]; then
    $HOME/Applications/nvim.appimage $@
  elif [ -x "$(command -v nvim)" ]; then
    nvim $@
  elif [ -x "$(command -v vim)" ]; then
    vim $@
  elif [ -x "$(command -v vi)" ]; then
    vi $@
  else
    echo 'vi function in .bash_aliases thinks no vi like is not installed'
  fi
}
alias vi='run_prefered_vim '

#===========================================================================
#= ruby -
#===========================================================================

function bundle_exec_or_not {
    if [ -e Gemfile ]; then
        bundle exec $*
    else
        command $*
    fi
}
alias be='bundle_exec_or_not '
alias ombe='overmind run bundle exec'

#===========================================================================
# tmux
#===========================================================================

# TmuXAllKeys - send keys to each pane in each window
function txak {
  default="C-c C-c C-c exit Enter"
  current_win=${session}:0
  for _win in $(tmux list-windows -F '#I'); do
    tmux select-window -t "$_win"
    for _pane in $(tmux list-panes -F '#P'); do
      tmux send-keys -t ${_pane} ${@-$default}
    done
  done
  tmux select-window -t "$current_win"
}

#===========================================================================
#= misc tools
#===========================================================================

if command -v kubectl &> /dev/null; then
  source <(kubectl completion bash)
  alias k=kubectl
  complete -F __start_kubectl k
fi
