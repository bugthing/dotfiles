"============================================================================
"= Editing style
"============================================================================
let mapleader = "\<Space>"

set timeoutlen=1000  " timeout quicker so using space as my leader is less PITA
set ttimeoutlen=100  " ^ see above ^
set expandtab        " Insert spaces instead of tabs in insert mode. Use spaces for indents
set tabstop=2        " Number of spaces that a <Tab> in the file counts for"
set shiftwidth=2     " Number of spaces to use for each step of (auto)indent"
set softtabstop=2    " Should be same as shiftwidth (when using shofttabs)
set wrap!            " Turn off word wrapping
set showmatch        " When a bracket is inserted, briefly jump to the matching one
set showcmd          " Display incomplete commands
set path+=**         " search from current directory down
set wildmode=longest:full,full
set backupdir=/var/tmp
set directory=/var/tmp    " Don't clutter my dirs up with swp and tmp files
set nobackup
set nowritebackup
set autoread              " if file changed outside vim, re-rad
set mouse=                " No mouse integration please
set ignorecase smartcase  " when \c is used
set laststatus=2     " Always show status line.
set number           " line numbers on
set relativenumber   " cusor position based line numbers in ruler
set gdefault         " Assume the /g flag on :s substitutions to act globally
set smartindent      " turn on smart indent
set hlsearch         " highlight search matches
set showmode         " show the mode on the last line
set history=10000    " keep more lines of history

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
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType perl setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

" even-out splits when nvim resized
autocmd VimResized * execute "normal! \<c-w>="

"============================================================================
"= Appearance
"============================================================================

syntax on
set termguicolors
set t_Co=256
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

"============================================================================
"= Plugin config
"============================================================================

" Ale linter
let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}

" Code snippets
let g:completion_enable_snippet = 'UltiSnips'

"============================================================================
"= Commands / Shortcuts / Keyboard bindings
"============================================================================

nnoremap <C-h> <Esc>:tabp<CR>
nnoremap <C-l> <Esc>:tabn<CR>

nnoremap Zz <C-w><\|<C-w>\|
nnoremap Zo <C-w>=

" copy/paste in more usual style
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi
set clipboard=unnamedplus  " neo vim will use wl-copy wl-paste if present

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

" Clear all registers
command! ClearReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" disable/enable LSP
command! Dlsp :lua vim.lsp.diagnostic.disable()
command! Elsp :lua vim.lsp.diagnostic.enable()

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
nnoremap <silent> <leader><cr> :ClearReg<cr>

" increment/decrement numbers
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>

" Leader key binds:
map <leader>n :call RenameFile()<cr>
map <Leader>p :e#<CR> " Re-Open Previously Opened File:
map <Leader>s :%s/\s\+$//e<CR>
map <Leader>w :set wrap!<CR>

" execute perl or ruby (depending on what filetype)
autocmd FileType perl map <leader>x :! perl %<CR>
autocmd FileType ruby map <leader>x :! ruby %<CR>
"autocmd FileType ruby imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

" my tmux has ctrl+a, so lets rename in vim to ctl+b
noremap <c-b> <c-a>

