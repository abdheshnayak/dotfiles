local lsp = vim.lsp
local lsp_config = require("lspconfig")

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  -- virtual_text = {
  --   prefix = "●",
  --   spacing = 12,
  -- },
  update_in_insert = true,
})

-- LSP signs default

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require'lsp.servers'
