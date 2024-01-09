-- telescope-conf.lua
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require('telescope.builtin')

telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
      },
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
	  find_files = {
	  	-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
	  	find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
	  },
    live_grep = {
	  	find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
  themes = {
    get_dropdown = {
      previewer = false, layout_config = { height = 15, width = 110 } 
    },
  },
  extensions = {
  }
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
