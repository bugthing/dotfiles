
let mapleader = "\<Space>"

"============================================================================
"= Editing style
"============================================================================
set nocompatible     " Use Vim defaults and forget about trying to be Vi"
set timeoutlen=1000  " timeout quicker so using space as my leader is less PITA
set ttimeoutlen=100  " ^ see above ^
set nobackup         " Stop slow saving with btrfs
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
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2     " Always show status line.
set number           " line numbers on
set relativenumber   " cusor position based line numbers in ruler
set gdefault         " Assume the /g flag on :s substitutions to act globally
set autoindent       " Always set autoindenting on
set noesckeys        " No delay when hitting esc
set smartindent      " turn on smart indent
set hlsearch         " highlight search matches
set hidden
set showmode         " show the mode on the last line
set history=100      " keep more lines of history
set term=screen-256color " help background color compatibility with xterm
setlocal cm=blowfish2 " set the encryption type

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
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" order of lookup when using completion
set complete=.,w,b,u,t,i,kspell

"============================================================================
"= Auto - commands
"============================================================================

" Indentation .. below we define filetype specific indentations..
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType perl setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" start NERDTree if we are not opening a specific file..
autocmd vimenter * if !argc() | NERDTree | endif
" close vim if NERDTree is last window open..
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" even-out splits when vim resized
autocmd VimResized * execute "normal! \<c-w>="

"============================================================================
"= Colour
"============================================================================

syntax on
set t_Co=256
let g:solarized_termcolors=256
set background=dark
" colorscheme vice
" colorscheme solarized
colorscheme dracula

" Tabline
hi TabLineFill  guifg=White guibg=DarkBlue  ctermfg=DarkBlue ctermbg=White
hi TabLine      guifg=White guibg=DarkBlue  ctermfg=White    ctermbg=DarkBlue
hi TabLineSel   guifg=White guibg=DarkGreen ctermfg=87       ctermbg=DarkGreen

"Highlight text wider that 78 characters
highlight OverLength ctermbg=black cterm=bold guibg=#592929
match OverLength /\%79v.\+/

"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" statusline - :help statusline
set statusline=%t\ %m%r%y%=(ascii=\%03.3b,hex=\%02.2B)\ (%l/%L,%c)\ (%P)
" change highlighting based on mode
highlight statusLine cterm=bold ctermfg=black ctermbg=blue
au InsertLeave * highlight StatusLine cterm=bold ctermfg=black ctermbg=blue
au InsertEnter * highlight StatusLine cterm=bold ctermfg=black ctermbg=green

"============================================================================
"= Programming specific stuff
"============================================================================

" .. perl stuff
let perl_include_pod   = 1    "include pod.vim syntax file with perl.vim"
let perl_extended_vars = 1    "highlight complex expressions such as @{[$x,$y]}"
let perl_sync_dist     = 250  "use more context for highlighting"

" .. ruby stuff
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"============================================================================
"= Functions
"============================================================================

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

function! CopyFilepathToGpaste()
    execute "silent !gpaste-client add" . " " . shellescape(fnamemodify(bufname("%"), ":p"))
    redraw!
endfunction

"============================================================================
"= Plugin config
"============================================================================

" statusline
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

let g:syntastic_ruby_checkers=['mri'] " 'rubocop', 'reek', 'flog', 'rubylint', 'macruby', 'jruby']
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*', '*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_ballons=has('ballon_eval')
let g:syntastic_auto_jump=1
let g:syntastic_loc_list_height=3
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_perl_checkers=['perl','perlcritic','podchecker']
let g:syntastic_python_checkers=['pylint','pep8','python']
let g:syntastic_cpp_checkers=['gcc','cppcheck','cpplint','ycm','clang_tidy','clang_check']
let g:syntastic_c_checkers=['gcc','make','cppcheck','clang_tidy','clang_check']
let g:syntastic_haml_checkers=['haml_lint', 'haml']
let g:syntastic_html_checkers=['jshint']
let g:syntastic_yaml_checkers=['jsyaml']
let g:syntastic_sh_checkers=['sh','shellcheck','checkbashisms']
let g:syntastic_vim_checkers=['vimlint']
let g:syntastic_enable_perl_checker=1
let g:syntastic_c_clang_tidy_sort=1
let g:syntastic_c_clang_check_sort=1
let g:syntastic_c_remove_include_errors=1
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }
let g:syntastic_stl_format = '[%E{E: %fe #%e}%B{, }%W{W: %fw #%w}]'
let g:syntastic_java_javac_options = "-g:none -source 8 -Xmaxerrs 5 -Xmaswarns 5"

" vim-notes - config
let g:notes_directories = ['~/.notes']
let g:notes_suffix = '.note'
let g:notes_title_sync = 'rename_file'

" ack.vim
if executable('rg')
  let g:ackprg = 'rg --vimgrep' " configure to use ripgrep
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep' " configure to use the_silver_searcher
endif

" vim-ruby
let g:rubycomplete_rails = 1
"let g:rubycomplete_buffer_loading = 1
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

" define custom commands
command! Rtags  :!bundle list --paths=true | xargs ctags --extra=+f --exclude=.git --exclude=tmp --exclude=log -R *
command! NT     :NERDTree %
" uses 'tidyhtml' package
command! Thtml  :%!tidy -q -i -ashtml 
command! Txhtml :%!tidy -q -i -asxhtml
command! Txml   :%!tidy -q -i -asxml
" uses python
command! Tjson  :%!python -m json.tool
" uses 'csstidy' package
command! Tcss   :%!csstidy -
" uses 'vim-scripts/SQLUtilities' plugin
command! Tsql   :SQLUFormatter

" vim-notes - shortcuts
cnoreabbrev Ns :SearchNotes
cnoreabbrev Nn :Note
cnoreabbrev Nd :DeleteNote
cnoreabbrev Nr :RecentNotes

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
map <leader>a :set autochdir!<CR>
map <leader>b :TlistToggle<CR>
map <Leader>c :w !gpaste-client<CR><CR>
map <leader>d :setlocal spell! spelllang=en_gb<CR>
map <Leader>e :tabe<CR>
map <Leader>f :let @"=expand("%")<CR>
map <Leader>d :call CopyFilepathToGpaste()<CR>
map <Leader>k :Ack!<Space>
map <leader>l :set list!<CR>
map <Leader>m :set wrap!<CR>
map <leader>n :call RenameFile()<cr>
" Re-Open Previously Opened File:
map <Leader>p :e#<CR>
map <Leader>q :qa<CR>
map <Leader>s :!bash<CR>
map <Leader>t :%s/\s\+$//e<CR>
map <Leader>w :w<CR>
map <leader>r :call SpecCorresponding()<CR>

" tmux has ctrl+a, so lets rename in vim to ctl+b
noremap <c-b> <c-a>

