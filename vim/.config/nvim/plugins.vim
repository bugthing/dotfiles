" ==================
" = Vim Plug config
" ==================

" install like so:
"   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then use PlugInstall to install plugins (or PlugUpdate or PlugClean, etc.)
" .. or auto-install
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/SQLUtilities'
Plug 'vim-ruby/vim-ruby' " the latest ruby support
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags' " auto tags generation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
