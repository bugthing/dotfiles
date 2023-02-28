nnoremap <leader>ff :lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({ previewer = false, layout_config = { height = 15, width = 110 } }))<CR>
nnoremap gd :lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap gr :lua require('telescope.builtin').lsp_references()<CR>
nnoremap gi :lua require('telescope.builtin').lsp_implementations()<CR>
