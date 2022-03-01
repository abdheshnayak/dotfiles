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
    base_dir .. "/sumneko_lua/extension/server/bin/lua-language-server",
  },
  go = {
    base_dir .. "/go/gopls",
  },
  css = {
    base_dir .. "/vscode-langservers-extracted/node_modules/.bin/vscode-css-language-server",
  },
  tailwindcss = {
    base_dir .. "/tailwindcss_npm/node_modules/.bin/tailwindcss-language-server",
    '--stdio',
  },
  json = {
    base_dir .. "/jsonls/node_modules/.bin/vscode-json-language-server",
    '--stdio',
  },
  docker = {
    base_dir .. "/dockerfile/node_modules/.bin/docker-langserver",
    '--stdio'
  },
  bashls = {
    base_dir .. "/bash/node_modules/.bin/bash-language-server",
    "start"
  },
  python = {
    base_dir .. "/python/node_modules/.bin/pyright-langserver",
    "--stdio"
  },
  eslint = {
    base_dir .. "/vscode-eslint/node_modules/.bin/vscode-eslint-language-server",
    "--stdio"
  },
  quicklint = {
    base_dir .. "/quick_lint_js/bin/quick-lint-js",
    "--lsp"
  }
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
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
  end
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
        checkThirdParty = false,
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
-- lsp_config.yamlls.setup(config({
--   cmd = lsp_servers.yaml,
--   filetypes = {"yaml", "yml"},
--   settings = {
--     yaml = {
--       schemaStore = {
--         url = "https://www.schemastore.org/api/json/catalog.json",
--         enable = true,
--       },
--     },
--   },
-- }))

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
  filetypes = {"javascriptreact", "typescriptreact", "html", "css"},
  root_dir = lsp_config.util.root_pattern('tailwind.config.js'),
  log_level = vim.lsp.protocol.MessageType.Warning;
  settings = {};
})

-- json
lsp_config.jsonls.setup({
  cmd = lsp_servers.json,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/npmpackagejsonlintrc.json",
        },
        {
          fileMatch = { "jsconfig.json" },
          url = "https://json.schemastore.org/jsconfig.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = {".eslintrc.json", ".eslintrc"},
          url = "https://json.schemastore.org/eslintrc.json",
        },
      },
    },
  },
})

-- Bash
lsp_config.bashls.setup({
  cmd = lsp_servers.bashls,
  filetypes = {"sh"},
})

-- Dockerfile
lsp_config.dockerls.setup({
  cmd = lsp_servers.docker,
  filetypes = {"Dockerfile", "dockerfile"};
  root_dir = lsp_config.util.root_pattern("Dockerfile");
  log_level = vim.lsp.protocol.MessageType.Warning;
  settings = {};
})

-- EFM

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename '${INPUT}'",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename='${INPUT}'",
  formatStdin = true,
}

local shell = {
  lintCommand = "shellcheck -f gcc -x",
  lintSource = 'shellcheck',
  lintFormats = {
    "%f:%l:%c: %m",
    "%f:%l:%c: %m (warning)",
    "%f:%l:%c: %m (error)",
  },
  formatCommand = "shfmt -c -i 2 -s -bn",
  formatStdin = true
}

local golangcilint = {
  lintCommand = "golangci-lint run",
  lintSource = "golanci-lint",
  init_options = {documentFormatting = false}, 
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
      typescriptreact = {eslint},
      sh = {shell},
      go= {golangcilint},
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

-- python lsp
require("lspconfig").pyright.setup({
  cmd = lsp_servers.python,
})

lsp_config.gopls.setup({
  cmd = lsp_servers.go,
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir = lsp_config.util.root_pattern("go.mod")
});

-- lsp_config.quick_lint_js.setup({
--   cmd = lsp_servers.quicklint,
-- })

-- require("lspconfig").eslint.setup({
--   cmd = lsp_servers.eslint,
--   root_dir = lsp_config.util.root_pattern(".eslintrc.yml"),
--   log_level = vim.lsp.protocol.MessageType.Warning;
-- })
