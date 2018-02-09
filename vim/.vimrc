"================================================================================
" = Vim RC - loads include files in correct order.
"================================================================================

"================================================================================
"= Local rc - exec the contents
"================================================================================
let s:localrc = expand($HOME . '/.vim/local.vimrc')
if filereadable(s:localrc)
  exec ':so ' . s:localrc
endif

"================================================================================
"= Addidional configuration - overwrite shorcuts, etc.
"================================================================================
if filereadable(expand("~/.vim/custom.vimrc"))
  source ~/.vim/custom.vimrc
endif
