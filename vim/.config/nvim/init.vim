
"================================================================================
" = NEO VIM CONFIG - loads include files in correct order.
"================================================================================

set nocompatible

"================================================================================
"= Plugins
"================================================================================
let s:config = expand(stdpath('config').'/plugins.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

"================================================================================
"= General Config
"================================================================================
let s:config = expand(stdpath('config').'/custom.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

"================================================================================
"= Plugin Config
"================================================================================
let s:config = expand(stdpath('config').'/fzf.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/gutentags.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif
