
"================================================================================
" = NEO VIM CONFIG - loads include files in correct order.
"================================================================================

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
let s:config = expand(stdpath('config').'/lsp.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/completion.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/fzf.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

" Status line
let s:config = expand(stdpath('config').'/statusline.lua')
if filereadable(s:config)
  luafile ~/.config/nvim/statusline.lua
endif

