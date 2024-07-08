-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<space>e', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', ':lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<space>q', ':lua vim.diagnostic.setloclist()<CR>')
vim.keymap.set('n', '<space>f', ':lua vim.lsp.buf.format()<CR>')


local funcs = require("funcs")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local attacher = function(client, bufnr)
  print('Attaching LSP: ' .. client.name)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- set default formatter (to avoid be asked to select)
  funcs.set_default_formatter_for_filetypes('standardrb', {'ruby'})
end

-- Setup all language servers
local lspconfig = require('lspconfig')

-- .. for ruby
lspconfig.solargraph.setup{
  settings = {
    solargraph = {
      commandPath = "~/.asdf/shims/solargraph",
      autoformat = false,
      formatting = false
    }
  },
  on_attach = attacher
}
-- .. for StandardRB's own LSP (see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#standardrb)
lspconfig.standardrb.setup{
  on_attach = attacher,
  cmd = {"bundle", "exec", "standardrb", "--lsp"},
}
---- .. for syntax_tree's own LSP (see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#syntax_tree)
--lspconfig.syntax_tree.setup{}
