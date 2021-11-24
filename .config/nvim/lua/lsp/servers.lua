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

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

lsp_config.efm.setup {
  cmd = {
    vim.fn.stdpath('data') .. '/lsp_servers/efm/efm-langserver',
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
  end,
  root_dir = lsp_config.util.root_pattern(".eslintrc.yml"),
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}

