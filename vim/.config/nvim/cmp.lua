local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<c-d>"] = cmp.mapping.scroll_docs(-4),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },

    ["<tab>"] = cmp.config.disable,
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = false,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        path = "[path]",
      },
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = false,
  },
}
