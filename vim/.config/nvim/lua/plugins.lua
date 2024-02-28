local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

-- tpope
Plug('tpope/vim-sensible')
Plug('tpope/vim-endwise')
Plug('machakann/vim-sandwich')
--  LSP
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/nvim-cmp')
Plug('onsails/lspkind-nvim')
--  Github
Plug('github/copilot.vim')
-- Fuzzy finder
Plug('nvim-lua/popup.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
-- Status line
Plug('NTBBloodbath/galaxyline.nvim', {branch = 'main' })
Plug('kyazdani42/nvim-web-devicons')

-- Testing
Plug('vim-test/vim-test')
Plug('preservim/vimux')

-- Opening assocaited files
Plug('rgroli/other.nvim')

vim.call('plug#end')


-- " install like so:
-- "   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
-- " then use PlugInstall to install plugins (or PlugUpdate or PlugClean, etc.)
-- " .. or auto-install
-- if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
--   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
--   autocmd VimEnter * PlugInstall | source $MYVIMRC
-- endif

-- " Automatically install missing plugins on startup
-- autocmd VimEnter *
--   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
--   \|   PlugInstall --sync | q
--   \| endif
-- 
