
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

let s:config = expand(stdpath('config').'/fzf.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/seeing-is-believing.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/copilot.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/telescope.vim')
if filereadable(s:config)
  exec ':source ' . s:config
endif

let s:config = expand(stdpath('config').'/statusline.lua')
if filereadable(s:config)
  execute "luafile " . s:config
endif

let s:config = expand(stdpath('config').'/lsp.lua')
if filereadable(s:config)
  execute "luafile " . s:config
endif

let s:config = expand(stdpath('config').'/cmp.lua')
if filereadable(s:config)
  execute "luafile " . s:config
endif

let s:config = expand(stdpath('config').'/ror.lua')
if filereadable(s:config)
  execute "luafile " . s:config
endif
