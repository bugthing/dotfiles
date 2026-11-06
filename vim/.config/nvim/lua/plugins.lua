-- Plugins via Neovim's built-in manager (vim.pack, Neovim 0.12+).
-- Missing plugins are cloned on startup; nothing to install first.
--   :lua vim.pack.update()      update (review, then :write to apply)
--   :lua vim.pack.del({'name'}) remove

-- Rebuild treesitter parsers after nvim-treesitter is installed or updated.
-- Must be defined before vim.pack.add().
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add({
  -- tpope
  gh('tpope/vim-sensible'),
  gh('tpope/vim-endwise'),
  gh('machakann/vim-sandwich'),
  -- LSP
  gh('neovim/nvim-lspconfig'),
  gh('hrsh7th/cmp-nvim-lsp'),
  gh('hrsh7th/cmp-path'),
  gh('hrsh7th/nvim-cmp'),
  gh('onsails/lspkind-nvim'),
  -- Github
  gh('github/copilot.vim'),
  -- llama.vim
  gh('ggml-org/llama.vim'),
  -- Fuzzy finder
  gh('nvim-lua/popup.nvim'),
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-treesitter/nvim-treesitter'),
  -- Status line
  gh('nvim-lualine/lualine.nvim'),
  gh('kyazdani42/nvim-web-devicons'),
  -- Testing
  gh('vim-test/vim-test'),
  gh('preservim/vimux'),
  -- Opening associated files
  gh('rgroli/other.nvim'),
}, { confirm = false })

-- Dev version of itype, only on machines that have the checkout.
local itype = vim.fn.expand('~/Sandbox/itype')
if vim.uv.fs_stat(itype) then
  vim.opt.runtimepath:prepend(itype)
end
