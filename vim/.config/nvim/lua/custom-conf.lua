vim.g.mapleader = ' '

-- turn off perl provider .. dont see it much any more :(
vim.g.loaded_perl_provider = 0

-- Editing style
--vim.api.nvim_set_keymap('n', '<Space>', '', {})
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 100
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.wrap = false
vim.o.showmatch = true
vim.o.showcmd = true
vim.o.path = vim.o.path .. '**'
vim.o.wildmode = 'longest:full,full'
vim.o.backupdir = '/var/tmp'
vim.o.directory = '/var/tmp'
vim.o.nobackup = true
vim.o.nowritebackup = true
vim.o.autoread = true
vim.o.mouse = ''
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.gdefault = true
vim.o.smartindent = true
vim.o.hlsearch = true
vim.o.showmode = true
vim.o.history = 10000

-- Filetype specific indentations
vim.api.nvim_exec([[
  autocmd FileType html setlocal shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
]], false)

-- Even-out splits when Neovim is resized
vim.api.nvim_exec([[ autocmd VimResized * execute "normal! \<c-w>=" ]], false)

-- Appearance
vim.cmd('syntax enable')
vim.o.termguicolors = true
vim.o.t_Co = 256
vim.o.background = 'dark'
vim.cmd('colorscheme vice')

-- Tabline
vim.cmd('hi TabLineFill guifg=White guibg=DarkBlue ctermfg=DarkBlue ctermbg=White')
vim.cmd('hi TabLine guifg=White guibg=DarkBlue ctermfg=White ctermbg=DarkBlue')
vim.cmd('hi TabLineSel guifg=White guibg=DarkGreen ctermfg=87 ctermbg=DarkGreen')

-- Highlight text wider than 78 characters
vim.cmd('highlight OverLength ctermbg=black cterm=bold guibg=#592929')
vim.cmd('match OverLength /\\%79v.\\+/')

-- Highlight trailing whitespace
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
vim.cmd('match ExtraWhitespace /\\s\\+$/')

-- Commands / Shortcuts / Keyboard bindings
vim.api.nvim_set_keymap('n', '<C-h>', ':tabp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabn<CR>', { noremap = true, silent = true })

-- Leader key binds
vim.api.nvim_set_keymap('n', '<Leader>n', ':lua require("funcs").rename_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', ':e#<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':%s/\\s\\+$//e<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':TestNearest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':call SpecCorresponding()<CR>', { noremap = true, silent = true })
