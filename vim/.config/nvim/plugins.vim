" ==================
" = Vim Plug config
" ==================

" install like so:
"   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then use PluginInstall to install plugins (or PluginUpdate or PluginClean, etc.)
"
call plug#begin(stdpath('data') . '/plugged')

Plug ('kien/ctrlp.vim')
Plug ('junegunn/fzf.vim') " fuzzy finder
Plug ('tpope/vim-surround')
Plug ('tpope/vim-repeat')
Plug ('godlygeek/tabular')
Plug ('vim-scripts/git-time-lapse')
Plug ('vim-scripts/Align')
Plug ('vim-scripts/SQLUtilities')
Plug ('vim-ruby/vim-ruby') " the latest ruby support
Plug ('w0rp/ale') " linting
Plug ('ludovicchabant/vim-gutentags') " auto tags generation
