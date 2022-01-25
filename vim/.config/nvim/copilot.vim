
" instead of Tab let use Ctl+J
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" disable copilot by default (enble with :Copilot enable)
let b:copilot_enabled = v:true
