local lsp_config = require("lspconfig")

local base_dir = vim.fn.stdpath("data") .. "/lsp_servers"
local lsp_servers = {
  tsserver = {
    base_dir .. "/tsserver/node_modules/.bin/typescript-language-server",
    "--stdio",
  },
  yaml = {
    base_dir .. "/yaml/node_modules/.bin/yaml-language-server",
    "--stdio",
  },
  lua = {
    base_dir .. "/sumneko_lua/extension/server/bin/Linux/lua-language-server",
  },
  go = {
    base_dir .. "/go/gopls",
  },
  css = {
    base_dir .. "/vscode-langservers-extracted/node_modules/.bin/vscode-css-language-server",
  },
  tailwindcss = {
    base_dir .. "/tailwindcss_npm/node_modules/.bin/tailwindcss-language-server",
  },
  json = {
    base_dir .. "/vscode-langservers-extracted/node_modules/.bin/vscode-json-language-server",
  },
}

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, _config or {})
end

-- tsserver
lsp_config.tsserver.setup(config({
  cmd = lsp_servers.tsserver,
  root_dir = lsp_config.util.root_pattern("jsconfig.json", "tsconfig.json", ".git"),
}))

-- sumneko_lua
lsp_config.sumneko_lua.setup(config({
  cmd = lsp_servers.lua,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      completion = { callSnippet = "Both" },
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      telemetry = { enable = true },
    },
  },
}))

-- -- yamlls
lsp_config.yamlls.setup(config({
  cmd = lsp_servers.yaml,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
}))

-- GoLang
lsp_config.gopls.setup({
  cmd = lsp_servers.go,
})

-- Css
lsp_config.cssls.setup({
  cmd = lsp_servers.css,
})

-- Tailwind CSS
lsp_config.tailwindcss.setup({
  cmd = lsp_servers.tailwindcss,
})

-- json
lsp_config.jsonls.setup({
  cmd = lsp_servers.json,
})

-- Bash
lsp_config.bashls.setup({})

-- Dockerfile
lsp_config.dockerls.setup({})

-- EFM
local efm_config = vim.fn.stdpath("config") .. "/lua/lsp/sources/efm-config.yaml"
local efm_log_dir = "/tmp"
local efm_root_markers = { "package.json", ".git/" }

local eslint = {
  lintCommand = "eslint_d --stdin --stdin-filename ${INPUT} -f unix",
  lintStdin = true,
  lintIgnoreExitCode = true,
}

local prettier = {
  formatCommand = "prettier_d_slim --find-config-path --stdin-filepath ${INPUT}",
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

local efm_cmd = vim.fn.stdpath('data') .. '/lsp_servers/efm/efm-langserver'

require("lspconfig").efm.setup({
  cmd = {
    efm_cmd,
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
  init_options = {
    document_formatting = true,
  },
  settings = {
    rootMarkers = efm_root_markers,
    languages = efm_languages,
  },
})
