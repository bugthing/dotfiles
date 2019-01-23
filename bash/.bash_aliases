#===========================================================================
# Work
#===========================================================================

function redis-clearout-rails {
  bundle exec rails runner 'Sidekiq.redis { |conn| conn.flushdb }'
}

function redis-clearout-docker {
  docker exec redis redis-cli flushall
}

function rspec-parallel-prep {
  bundle exec rake parallel:create
  bundle exec rake parallel:prepare
  rspec-parallel
}

function rspec-parallel {
  bundle exec parallel_rspec ./spec
}

function reviewapp-db-reset {
  reviewapp-run $1 "rake environment db:drop db:create db:schema:load db:seed:development DISABLE_DATABASE_ENVIRONMENT_CHECK=1 SAFETY_ASSURED=1"
}

function reviewapp-console {
  reviewapp-run $1 "rails console"
}

function reviewapp-bash {
  reviewapp-run $1 "bash"
}

function reviewapp-run {
  prnumber=$1
  cmd=$2
  re='^[0-9]+$'
  if ! [[ $prnumber =~ $re ]] ; then
    echo 'Please provide a pr number (for reviewapp)'
    return 1
  fi
  heroku run -a sp-api-sandbox-pr-${prnumber} ${cmd}
}

function sp-api-db-reset {
  bundle exec rake environment db:drop db:create db:schema:load db:seed:development
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
  tar c "$1" | pv | tar x -C "$2"
}

function wallp () {
  feh --recursive --randomize --bg-fill $HOME/Pictures/HomeSync/Wallpapers/*
}

#===========================================================================
# Binding keys
#===========================================================================

# Alt+l = pwd \n (example)
bind '"\el": "\C-upwd\n"'

#===========================================================================
#= git -
#===========================================================================

alias gs='git status '
alias ga='git add '
alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gd='git diff'
alias gco='git checkout '
alias vcon='vim -p $(git status | grep "both modified" | cut -d: -f2)'
alias gvl='git log | vim -c "set keywordprg=git\ show" -R -'

#===========================================================================
#= (re)define commands
#===========================================================================

alias aptup='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias ll='ls -la'
alias ssh-nokey='ssh  -o "IdentitiesOnly yes" '

#= .. add colour (if available)  ..
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

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

function rcam () {
  bundle_exec_or_not rubocop -a --force-exclusion `git diff master --name-only --cached --diff-filter=ACMRTB`
}

# Only run rubocop on changed files
function ed209 {
  git status --porcelain | grep -v '^D' | grep '\.rb$' | cut -d ' ' -f 3 | xargs rubocop
}

#===========================================================================
# vim-notes
#===========================================================================

# Opens a note
function ne {
  vim -c ":Note $*"
}
 ## New Note: calls vim notes plugin
function n {
  vim -c :Note
}
 # Searches Notes
function  nls {
  ls -c ~/.notes/ | egrep -i "$*"
}
 # open searched note
function nos {
  found=$(nls $*)
  linecount=`echo "$found" | wc -l`
  if [ "$linecount" != "1" ]; then
    echo "$found"
    echo "Search must find only 1 (see above)"
    return 1
  fi
  notename=${found/.note/}
  echo "Opening note ($linecount) ${notename}.."
  ne $notename
}

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
