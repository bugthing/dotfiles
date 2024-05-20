local g = vim.g       -- global variables
local o = vim.o       -- options, global only options
local opt = vim.opt   -- options, global/buffer/windows
local api = vim.api   -- address the vim api
local cmd = vim.cmd   -- vim commands

-----------------------------------------------------------
-- General
-----------------------------------------------------------
o.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
o.swapfile = false                  -- Don't use swapfile
o.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
o.wildmode = 'longest:full,full'
o.backupdir = '/var/tmp'
o.directory = '/var/tmp'
o.path = vim.o.path .. '**'
o.autoread = true
o.mouse = ''
o.ignorecase = true
o.smartcase = true
o.laststatus = 2
o.gdefault = true
o.smartindent = true
o.hlsearch = true
o.showmode = true
o.splitright = true
o.splitbelow = true
g.loaded_perl_provider = 0 -- turn off perl provider .. dont see it much any more :(

-----------------------------------------------------------
-- UI
-----------------------------------------------------------
o.number = true           -- Show line number
o.relativenumber = true
o.showmatch = true        -- Highlight matching parenthesis
o.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
o.colorcolumn = '80'      -- Line lenght marker at 80 columns
o.splitright = true       -- Vertical split to the right
o.splitbelow = true       -- Horizontal split to the bottom
o.ignorecase = true       -- Ignore case letters when search
o.smartcase = true        -- Ignore lowercase for the whole pattern
o.linebreak = true        -- Wrap on word boundary
o.termguicolors = true    -- Enable 24-bit RGB colors
o.laststatus=3            -- Set global statusline
o.wrap = false
o.showcmd = true
cmd('syntax enable')
opt.termguicolors = true
o.background = 'dark'
cmd('colorscheme vice')
api.nvim_exec([[ autocmd VimResized * execute "normal! \<c-w>=" ]], false) -- Even-out splits when Neovim is resized

-- .. Tabline
cmd('hi TabLineFill guifg=White guibg=DarkBlue ctermfg=DarkBlue ctermbg=White')
cmd('hi TabLine guifg=White guibg=DarkBlue ctermfg=White ctermbg=DarkBlue')
cmd('hi TabLineSel guifg=White guibg=DarkGreen ctermfg=87 ctermbg=DarkGreen')

-- .. Highlight text wider than 78 characters
cmd('highlight OverLength ctermbg=black cterm=bold guibg=#592929')
cmd('match OverLength /\\%79v.\\+/')

-- .. Highlight trailing whitespace
cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
cmd('match ExtraWhitespace /\\s\\+$/')

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.smartindent = true      -- Autoindent new lines
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- ... filetype specific indentations
api.nvim_exec([[
  autocmd FileType html setlocal shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
]], false)


-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 10000
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 250        -- ms to wait for trigger an event
opt.timeoutlen = 1000
opt.ttimeoutlen = 100

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

-----------------------------------------------------------
-- Leader key
-----------------------------------------------------------
g.mapleader = ' '
api.nvim_set_keymap('n', '<Leader>n', ':lua require("funcs").rename_file()<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>r', ':lua require("funcs").spec_corresponding()<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>p', ':e#<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>s', ':%s/\\s\\+$//e<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>w', ':set wrap!<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>t', ':TestNearest<CR>', { noremap = true, silent = true })

-----------------------------------------------------------
-- Shortcuts / Keyboard bindings
-----------------------------------------------------------
api.nvim_set_keymap('n', '<C-h>', ':tabp<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-l>', ':tabn<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-N><C-N>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', { noremap = true, silent = true });


