"============================================================================
"= Editing style
"============================================================================
let mapleader = "\<Space>"

set nocompatible     " Use Vim defaults and forget about trying to be Vi"
set timeoutlen=1000  " timeout quicker so using space as my leader is less PITA
set ttimeoutlen=100  " ^ see above ^
set expandtab        " Insert spaces instead of tabs in insert mode. Use spaces for indents
set tabstop=4        " Number of spaces that a <Tab> in the file counts for"
set shiftwidth=4     " Number of spaces to use for each step of (auto)indent"
set softtabstop=4    " Should be same as shiftwidth (when using shofttabs)
set wrap!            " Turn off word wrapping
set backspace=2      " Allow backspacing over everything in insert mode"
set showmatch        " When a bracket is inserted, briefly jump to the matching one
set ruler            " Display line and column numbers
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showcmd          " Display incomplete commands
set autoindent
set showmatch
set nowrap
set listchars=tab:▸\ ,eol:¬ " change how to display some invisibles chars
set path+=**           " search from current directory down
set wildmenu
set wildmode=longest:full,full
set backupdir=/var/tmp
set directory=/var/tmp " Don't clutter my dirs up with swp and tmp files
set nobackup
set nowritebackup
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set et
set sw=2
set smarttab
set noincsearch
set mouse=           " No mouse integration please
set ignorecase smartcase
set laststatus=2     " Always show status line.
set number           " line numbers on
set relativenumber   " cusor position based line numbers in ruler
set gdefault         " Assume the /g flag on :s substitutions to act globally
set autoindent       " Always set autoindenting on
set smartindent      " turn on smart indent
set hlsearch         " highlight search matches
set hidden
set showmode         " show the mode on the last line
set history=100      " keep more lines of history

" more natural split opening
set splitbelow
set splitright
set pastetoggle=<F2>
" start editing where I prevously left the file.
au BufWinLeave ?* silent! mkview 1
au BufWinEnter ?* silent! loadview 1

" set fold method and ensure it saves when done editing
set foldmethod=syntax
set foldlevelstart=3

" allow undoing even after you have closed a file (ensure directory exists)
set undofile
set undodir=~/temp/nvim-undodir
set undolevels=10000
set undoreload=10000

" order of lookup when using completion
set complete=.,w,b,u,t,i,kspell

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

"============================================================================
"= Auto - commands
"============================================================================

" Indentation .. below we define filetype specific indentations..
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType perl setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

" even-out splits when nvim resized
autocmd VimResized * execute "normal! \<c-w>="

"============================================================================
"= Appearance
"============================================================================

syntax on
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme vice

" tabline
hi TabLineFill  guifg=White guibg=DarkBlue  ctermfg=DarkBlue ctermbg=White
hi TabLine      guifg=White guibg=DarkBlue  ctermfg=White    ctermbg=DarkBlue
hi TabLineSel   guifg=White guibg=DarkGreen ctermfg=87       ctermbg=DarkGreen

" highlight text wider that 78 characters
highlight OverLength ctermbg=black cterm=bold guibg=#592929
match OverLength /\%79v.\+/

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" statusline - :help statusline
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%#warningmsg#
set statusline+=%{LinterStatus()}      " linter warnings
set statusline+=%*
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" change highlighting based on mode
highlight statusLine cterm=bold ctermfg=black ctermbg=blue
au InsertLeave * highlight StatusLine cterm=bold ctermfg=black ctermbg=blue
au InsertEnter * highlight StatusLine cterm=bold ctermfg=black ctermbg=green

"============================================================================
"= Functions
"============================================================================

function! ReplayLastMacro()
  try
    normal @@
  catch /E748/
    normal @q
  endtry
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

function! SpecCorresponding()
  let l:efile = @%
  if match(expand(l:efile), "_spec.rb$") != -1
    let l:cfile = substitute(l:efile, "_spec.rb$", ".rb", "s")
    let l:cfile = substitute(l:cfile, "spec/", "app/", "s")
    execute("rightbelow vsplit " . l:cfile)
  else
    let l:cfile = substitute(l:efile, ".rb$", "_spec.rb", "s")
    let l:cfile = substitute(l:cfile, "app/", "spec/", "s")
    execute("leftabove vsplit " . l:cfile)
  endif
endfunction

function! LinterStatus() abort
    if &rtp !~ 'ale'
      return 'no ale'
    endif

    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

if !exists( "*RubyEndToken" )
    function RubyEndToken()
        let current_line = getline( '.' )
        let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
        let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
        let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

        if match(current_line, braces_at_end) >= 0
            return "\<CR>}\<C-O>O"
        elseif match(current_line, stuff_without_do) >= 0
            return "\<CR>end\<C-O>O"
        elseif match(current_line, with_do) >= 0
            return "\<CR>end\<C-O>O"
        else
            return "\<CR>"
        endif
    endfunction
endif

"============================================================================
"= Plugin config
"============================================================================

" vim-ruby
let g:rubycomplete_load_gemfile = 1

" tabular
cnoreabbrev Lu :Tabularize

" in-built matchit
runtime! macros/matchit.vim

" CTags - open ctag in tab/vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"============================================================================
"= Commands / Shortcuts / Keyboard bindings
"============================================================================

nnoremap <C-h> <Esc>:tabp<CR>
nnoremap <C-l> <Esc>:tabn<CR>

" copy/paste in more usual style
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi
set clipboard=unnamedplus	" neo vim will use wl-copy wl-paste if present

" define custom commands
command! Rtags  :!bundle list --paths=true | xargs ctags --extra=+f --exclude=.git --exclude=tmp --exclude=log -R *

" tidy commands.
" .. uses 'tidyhtml' package
command! Thtml  :%!tidy -q -i -ashtml
command! Txhtml :%!tidy -q -i -asxhtml
command! Txml   :%!tidy -q -i -asxml
" .. uses python
command! Tjson  :%!python -m json.tool
" .. uses 'csstidy' package
command! Tcss   :%!csstidy -
" .. uses 'vim-scripts/SQLUtilities' plugin
command! Tsql   :SQLUFormatter

" line number toggle
:nmap <C-N><C-N> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" make tab in v mode indent code"
vmap <tab> >gv
vmap <s-tab> <gv
" make tab in normal mode indent code"
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" auto toggle paste mode by detecting terminal's bracketed paste mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" save with sudo with :w!!
cmap w!! w !sudo tee % >/dev/null

" <enter> in normal mode just replays last macro
nnoremap <silent> <cr> :call ReplayLastMacro()<cr>

"" resize splits
"nnoremap <C-H> <C-w>>
"nnoremap <C-J> <C-w>-
"nnoremap <C-K> <C-w>+
"nnoremap <C-L> <C-w><

" Leader key binds:
map <leader>gt :call TimeLapse()<CR>
" execute perl or ruby (depending on what filetype)
autocmd FileType perl map <leader>x :! perl %<CR>
autocmd FileType ruby map <leader>x :! ruby %<CR>
autocmd FileType ruby imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
map <leader>a :set autochdir!<CR>
map <Leader>c :call CopyFileContentToGpaste()<CR>
map <leader>d :setlocal spell! spelllang=en_gb<CR>
map <Leader>e :tabe<CR>
map <leader>f :Files<CR>
map <leader>g :Rg<CR>
map <leader>l :set list!<CR>
nnoremap <leader>m :Marks<CR>
map <leader>n :call RenameFile()<cr>
" Re-Open Previously Opened File:
map <Leader>p :e#<CR>
map <Leader>q :qa<CR>
map <Leader>s :!bash<CR>
exec 'nnoremap <Leader>ss :mks! ~/vim-sessions/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so   ~/vim-sessions/*.vim<C-D><BS><BS><BS><BS><BS>'
map <Leader>t :%s/\s\+$//e<CR>
map <Leader>w :set wrap!<CR>
map <leader>r :call SpecCorresponding()<CR>

" tmux has ctrl+a, so lets rename in vim to ctl+b
noremap <c-b> <c-a>
