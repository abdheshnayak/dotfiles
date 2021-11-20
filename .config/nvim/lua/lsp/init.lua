local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    prefix = "●",
    spacing = 12,
  },
  update_in_insert = true,
})

-- LSP signs default
vim.fn.sign_define(
  "DiagnosticSignError",
  { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
)

vim.fn.sign_define(
  "DiagnosticSignWarning",
  { texthl = "DiagnosticSignWarning", text = "", numhl = "DiagnosticSignWarning" }
)

vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })

vim.fn.sign_define(
  "DiagnosticSignInformation",
  { texthl = "DiagnosticSignInformation", text = "", numhl = "DiagnosticSignInformation" }
)

-- LSP Enable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = false,
--   underline = true,
--   signs = true,
--   update_in_insert = false,
-- })

-- lua, typescript, dockerfile, efm, html, css,

--- Languages

local lsp_installer = require("nvim-lsp-installer")

local on_attach = require("lsp.on_attach")

require("lspconfig").sumneko_lua.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server",
    "-E",
    vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/main.lua",
  },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "use", "vim" },
      },
      workspace = {
        preloadFileSize = 350,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Typescript/Javascript
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = true,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = (function()
        local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
        table.sort(res)
        return res
      end)(),
    },
  },
}

-- require("lspconfig").tsserver.setup({
--   cmd = {
--     vim.fn.stdpath("data") .. "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server",
--     "--stdio",
--   },
--   capabilities = capabilities,
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     on_attach(client)
--   end,
-- })

-- GoLang
require("lspconfig").gopls.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/go/gopls",
  },
})

-- Css
require("lspconfig").cssls.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/vscode-langservers-extracted/node_modules/.bin/vscode-css-language-server",
  },
})

-- Tailwind CSS
require("lspconfig").tailwindcss.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/tailwindcss_npm/node_modules/.bin/tailwindcss-language-server",
  },
})

-- json
require("lspconfig").jsonls.setup({
  cmd = {
    vim.fn.stdpath("data") .. "vscode-langservers-extracted/node_modules/.bin/vscode-json-language-server",
  },
})

-- Bash
require("lspconfig").bashls.setup({})

-- Dockerfile
require("lspconfig").dockerls.setup({})

-- EFM
local efm_config = vim.fn.stdpath("config") .. "/lua/lsp/sources/efm-config.yaml"
local efm_log_dir = "/tmp"
local efm_root_markers = { "package.json", ".git/", ".zshrc" }

local eslint = {
  lintCommand = "eslint_d --stdin --stdin-filename ${INPUT} -f unix",
  lintStdin = true,
  lintIgnoreExitCode = true,
}

local prettier = {
  formatCommand = "prettier --find-config-path --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  markdown = { prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  graphql = { prettier },
  vue = { prettier },
  html = { prettier },
}

local efmServerPath = vim.fn.stdpath("data") .. "/lsp_servers/efm/efm-langserver"

require("lspconfig").efm.setup({
  cmd = {
    efmServerPath,
    "-c",
    efm_config,
    "-logfile",
    efm_log_dir .. "/logfile.log",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  on_attach = on_attach,
  init_options = {
    document_formatting = false,
  },
  settings = {
    rootMarkers = efm_root_markers,
    languages = efm_languages,
  },
})

-- make sure to only run this once!
require("lspconfig").tsserver.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server",
    "--stdio",
  },
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint",
      eslint_enable_diagnostics = false,
      eslint_opts = {},

      -- formatting
      enable_formatting = false,
      formatter = "prettier",
      formatter_opts = {},

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end,
})
