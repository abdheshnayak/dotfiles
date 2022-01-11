vim.diagnostic.config({
    underline = {
      severity = 'Error',
    },
    virtual_text = false,
    float = {
      source = 'always',
      focusable = false,
      border = 'single',
    },
})

-- LSP signs default
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require'lsp.servers'
