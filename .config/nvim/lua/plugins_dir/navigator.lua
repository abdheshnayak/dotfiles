local on_attach = require("lsp.on_attach")

local lsp_config = require("lspconfig")

require("navigator").setup({
  on_attach = on_attach,

  lsp = {
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
    tsserver = {
      cmd = {
        vim.fn.stdpath("data") .. "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server",
        "--stdio",
      },

      root_dir = lsp_config.util.root_pattern("jsconfig.json", "tsconfig.json", ".git"),
    },
  },
})
