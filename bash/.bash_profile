
# Source .profile if its there
[[ -f ~/.profile ]] && . ~/.profile

# Source .bashrc if required - http://unix.stackexchange.com/questions/10689/how-can-i-tell-if-im-in-a-tmux-session-from-a-bash-script
case $- in *i*) . ~/.bashrc;; esac
