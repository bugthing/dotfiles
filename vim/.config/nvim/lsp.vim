
lua <<EOF

local lspconfig = require'lspconfig'

local function attacher(client)
  print('Attaching LSP: ' .. client.name)
end

lspconfig.jsonls.setup{
  on_attach = attacher
}

lspconfig.solargraph.setup{
  settings = {
    solargraph = {
      commandPath = '/home/benjamin/.asdf/shims/solargraph',
      diagnostics = true,
      completion = true
    }
  },

  on_attach = attacher
}
EOF
