local M = {}

function M.disable_builtin_plugins()
  local disabled_built_ins = {
    "gzip",
    "tar",
    "tarPlugin",
    "zip",
    "zipPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "matchit",
    "matchparen",
    "2html_plugin",
    "logiPat",
    "rrhelper",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
  }

  for _, plugin in ipairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end
end

function M.disable_unused_providers()
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
end

return M
