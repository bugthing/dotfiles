-- The default settings
require("ror").setup({
  minitest = {
    message = {
      file = "Running all the tests...",
      -- This will be follow by a space, current cursor line number and ...
      -- E.g. Running test on line 10...
      line = "Running test on line"
    },
    pass_icon = "✅",
    fail_icon = "❌"
  }
})

--
-- require("luasnip.loaders.from_vscode").lazy_load()
-- Set a keybind to the below commands, some example:
vim.keymap.set("n", "<Leader>tf", ":lua require('ror.test').run()<CR>")
vim.keymap.set("n", "<Leader>tl", ":lua require('ror.test').run('Line')<CR>")
vim.keymap.set("n", "<Leader>tc", ":lua require('ror.test').clear()<CR>")
vim.keymap.set("n", "<Leader>ta", ":lua require('ror.test').attach_terminal()<CR>")

