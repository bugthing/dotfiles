-- Custom helper functions go in here

local M = {}

local set_contains = function (set, val)
  for key, value in pairs(set) do
    if value == val then return true end
  end
  return false
end

-- used to set a default formatter to avoid neovim prompting to make a choice
function M.set_default_formatter_for_filetypes(language_server_name, filetypes)
  if not set_contains(filetypes, vim.bo.filetype) then
    return
  end

  local active_servers = {}

  vim.lsp.for_each_buffer_client(0, function(client)
    table.insert(active_servers, client.config.name)
  end)

  if not set_contains(active_servers, language_server_name) then
    return
  end

  vim.lsp.for_each_buffer_client(0, function(client)
    if client.name ~= language_server_name then
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end
  end)
end

return M
