
-- lsp_config.quick_lint_js.setup({
--   cmd = lsp_servers.quicklint,
-- })

-- require("lspconfig").eslint.setup({
--   cmd = lsp_servers.eslint,
--   root_dir = lsp_config.util.root_pattern(".eslintrc.yml"),
--   log_level = vim.lsp.protocol.MessageType.Warning;
-- })

-- EFM
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
}

local shell = {
  lintCommand = "shellcheck -f gcc -x",
  lintSource = "shellcheck",
  lintFormats = {
    "%f:%l:%c: %m",
    "%f:%l:%c: %m (warning)",
    "%f:%l:%c: %m (error)",
  },
  formatCommand = "shfmt -c -i 2 -s -bn",
  formatStdin = true,
}

local golangcilint = {
  lintCommand = "golangci-lint run",
  lintSource = "golanci-lint",
  init_options = { documentFormatting = false },
}

lsp_config.efm.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/efm/efm-langserver",
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
  end,
  root_dir = lsp_config.util.root_pattern(".eslintrc.yml"),
  settings = {
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      ["javascript.jsx"] = { eslint },
      typescript = { eslint },
      ["typescript.tsx"] = { eslint },
      typescriptreact = { eslint },
      sh = { shell },
      go = { golangcilint },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
})
