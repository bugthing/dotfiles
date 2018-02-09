
"==================================================================
"= Vundle - https://github.com/gmarik/vundle
"==================================================================

set nocompatible

" install minpac (vim 8 packagemanger)
"  $ mkdir -p ~/.vim/pack/minpac/opt
"  $ cd ~/.vim/pack/minpac/opt
"  $ git clone https://github.com/k-takata/minpac.git

packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type':'opt'}) " minpac can update itself
call minpac#add('universal-ctags/ctags')
call minpac#add('scrooloose/nerdtree')
call minpac#add('kien/ctrlp.vim')
call minpac#add('mileszs/ack.vim')
call minpac#add('vim-scripts/git-time-lapse')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('godlygeek/tabular')
call minpac#add('vim-scripts/Align')
call minpac#add('vim-scripts/SQLUtilities')
call minpac#add('vim-ruby/vim-ruby') " the latest ruby support
call minpac#add('xolox/vim-misc') " required for note taking plugin
call minpac#add('xolox/vim-notes') " note taking
call minpac#add('scrooloose/syntastic') " syntax checking
call minpac#add('elixir-editors/vim-elixir') " elixir syntax highlighting

command! Bundle call minpac#update()
command! BundleClean call minpac#clean()
