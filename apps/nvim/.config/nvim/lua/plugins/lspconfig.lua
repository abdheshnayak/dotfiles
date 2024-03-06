vim.diagnostic.config({
  underline = {
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  virtual_text = {
    -- prefix = "☠ ",
    prefix = " ● ",
    severity = vim.diagnostic.severity.ERROR,
    only_current_line = true,
  },
  -- virtual_text = false,
  signs = {
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  float = {
    source = "always",
    focusable = false,
    border = "single",
  },
})

local function on_attach(client, bufnr)
  local opts = { silent = true, buffer = bufnr, remap = false }

  if client.server_capabilities then
    client.server_capabilities.semanticTokensProvider = nil
  end

  vim.keymap.set("n", "sn", function()
    vim.diagnostic.goto_next({
      severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
    })
  end, opts)

  vim.keymap.set("n", "sp", function()
    vim.diagnostic.goto_prev({
      severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
    })
  end, opts)

  vim.keymap.set("n", "se", vim.diagnostic.open_float, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set({ "n", "v" }, "<M-CR>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "f;", function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        if
            vim.bo.filetype == "javascriptreact"
            or vim.bo.filetype == "typescriptreact"
            or vim.bo.filetype == "javascript"
            or vim.bo.filetype == "typescript"
        then
          return client.name == "null-ls"
        end
        return true
      end,
      -- bufnr = bufnr,
    })

    -- vim.lsp.buf.format({ async = false })
  end, opts)

  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, opts)
  vim.keymap.set("n", "gi", "<Cmd>Telescope lsp_implementations<CR>", opts)
  -- vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references({ include_current_line = false, show_line = false })
  end, opts)
  vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
  vim.keymap.set("n", "gD", "<Cmd>Telescope lsp_type_definitions<CR>", opts)
  vim.keymap.set("n", "sr", vim.lsp.buf.rename, opts)
end

-- LSP signs default
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- setting up lsp servers

local lsp_config = require("lspconfig")

local base_dir = vim.fn.stdpath("data") .. "/mason/bin"
local lsp_servers = {
  tsserver = {
    base_dir .. "/typescript-language-server",
    "--stdio",
  },
  graphql = {
    base_dir .. "/graphql-lsp",
    "server",
    "-m",
    "stream",
  },
  rome = {
    base_dir .. "/rome",
    -- "--stdio",
  },
  yaml = {
    base_dir .. "/yaml-language-server",
    "--stdio",
  },
  lua = {
    base_dir .. "/lua-language-server",
  },
  go = {
    base_dir .. "/gopls",
  },
  eslint_d = {
    base_dir .. "/eslint_d",
    "--stdio",
  },
  css = {
    base_dir .. "/vscode-langservers-extracted/node_modules/.bin/vscode-css-language-server",
  },
  tailwindcss = {
    base_dir .. "/tailwindcss-language-server",
    "--stdio",
  },
  json = {
    base_dir .. "/jsonls/node_modules/.bin/vscode-json-language-server",
    "--stdio",
  },
  docker = {
    base_dir .. "/docker-langserver",
    "--stdio",
  },
  bashls = {
    base_dir .. "/bash-language-server",
    "start",
  },
  r_language_server={
    base_dir .. "/r-languageserver"
  },
  python = {
    base_dir .. "/pyright-langserver",
    "--stdio",
  },
  quicklint = {
    base_dir .. "/quick_lint_js/bin/quick-lint-js",
    "--lsp",
  },
  terraform = {
    base_dir .. "/terraform-ls",
    "serve",
  },
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Code actions
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        "",
        "quickfix",
        "refactor",
        "refactor.extract",
        "refactor.inline",
        "refactor.rewrite",
        "source",
        "source.organizeImports",
      },
    },
  },
}

capabilities.document_formatting = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require("cmp_nvim_lsp").default_capabilities(capabilities)

-- local function config(_config)
-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 	capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- 	-- return require("coq").lsp_ensure_capabilities(_config or {})
-- 	return vim.tbl_deep_extend("force", {
-- 		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
-- 	}, _config or {})
-- end

-- Add bun for Node.js-based servers
-- local lspconfig_util = require("lspconfig.util")
-- local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
-- lspconfig_util.on_setup = lspconfig_util.add_hook_before(lspconfig_util.on_setup, add_bun_prefix)

lsp_config.r_language_server.setup({
  cmd = lsp_servers.r_language_server,
  capabilities = capabilities,
  root_dir = lsp_config.util.root_pattern(".git"),
  filetypes = { "r" },
  on_attach = function(client)
    client.config.flags.allow_incremental_sync = true
    client.server_capabilities.document_formatting = true
    on_attach(client)
  end,
})

-- tsserver
lsp_config.tsserver.setup({
  cmd = lsp_servers.tsserver,
  capabilities = capabilities,
  root_dir = lsp_config.util.root_pattern("jsconfig.json", "tsconfig.json", "package.json", ".git"),
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- in pattern +xyz.abc.ts starts with + needs to be ignored
  ignore_pattern = "[/\\\\]%..+%.ts$",
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
})

-- lsp_config.eslint.setup({
--   cmd = lsp_servers.eslint_d,
--   on_attach = on_attach,
--   root_dir = lsp_config.util.root_pattern(".eslintrc.yml", "package.json"),
-- })

lsp_config.dartls.setup({
  cmd = lsp_servers.dartls,
  root_dir = lsp_config.util.root_pattern("pubspec.yaml"),
  capabilities = capabilities,
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
})

-- lsp_config.rome.setup({
--   on_attach = on_attach,
-- })
--
lsp_config.graphql.setup({
  cmd = lsp_servers.graphql,
  on_attach = on_attach,
  filetypes = { "typescript" },
  root_dir = lsp_config.util.root_pattern("gqlgen.yml", ".graphql.config.*", "graphql.config.*"),
})

-- sumneko_lua
-- local luadev = require("neodev").setup({
-- 	lspconfig = {
-- 		cmd = lsp_servers.lua,
-- 		settings = {
-- 			Lua = {
-- 				runtime = {
-- 					version = "LuaJIT",
-- 				},
-- 				completion = { callSnippet = "Both" },
-- 				diagnostics = {
-- 					globals = { "vim", "use" },
-- 				},
-- 			},
-- 		},
-- 	},
-- })

require("neodev").setup({
  capabilities = capabilities,
  library = {
    plugins = {
      "nvim-dap-ui",
      "neotest",
    },
    types = true,
  },
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp_config.lua_ls.setup({
  cmd = lsp_servers.lua,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        path = runtime_path,
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- -- yamlls
-- lsp_config.yamlls.setup({
--     cmd = lsp_servers.yaml,
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "yaml", "yml" },
--     settings = {
--         yaml = {
--             schemaStore = {
--                 url = "https://www.schemastore.org/api/json/catalog.json",
--                 enable = true,
--             },
--         },
--     },
-- })

-- Css
lsp_config.cssls.setup({
  capabilities = capabilities,
  cmd = lsp_servers.css,
  filetypes = { "css" },
  on_attach = on_attach,
})

-- Tailwind CSS
lsp_config.tailwindcss.setup({
  cmd = lsp_servers.tailwindcss,
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "javascriptreact", "typescriptreact", "html", "css", "svelte" },
  root_dir = lsp_config.util.root_pattern("tailwind.config.*"),
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {},
})

lsp_config.svelte.setup({
  cmd = { "svelteserver", "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "svelte" },
  root_dir = lsp_config.util.root_pattern("svelte.config.*"),
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {},
})

-- -- json
-- lsp_config.jsonls.setup({
-- 	cmd = lsp_servers.json,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	settings = {
-- 		json = {
-- 			--[[
-- 			schemas = require("schemastore").json.schemas({
-- 				select = {
-- 					"package.json",
-- 					"jsconfig.json",
-- 					"tsconfig.json",
-- 					"eslintrc.json",
-- 				},
-- 			}),
-- 			--]]
-- 			-- validate = { enable = true },
-- 			schemas = {
-- 				{
-- 					fileMatch = { "package.json" },
-- 					url = "https://json.schemastore.org/npmpackagejsonlintrc.json",
-- 				},
-- 				{
-- 					fileMatch = { "jsconfig.json" },
-- 					url = "https://json.schemastore.org/jsconfig.json",
-- 				},
-- 				{
-- 					fileMatch = { "tsconfig.json" },
-- 					url = "https://json.schemastore.org/tsconfig.json",
-- 				},
-- 				{
-- 					fileMatch = { ".eslintrc.json", ".eslintrc" },
-- 					url = "https://json.schemastore.org/eslintrc.json",
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- Bash
lsp_config.bashls.setup({
  cmd = lsp_servers.bashls,
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "sh" },
})

-- Dockerfile
lsp_config.dockerls.setup({
  cmd = lsp_servers.docker,
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "Dockerfile", "dockerfile" },
  root_dir = lsp_config.util.root_pattern("Dockerfile"),
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {},
})

-- python lsp
lsp_config.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = lsp_servers.python,
})

lsp_config.gopls.setup({
  cmd = lsp_servers.go,
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      analyses = {
        unreachable = true,
        unusedparams = true,
        shadow = false,
        unusedwrite = true,
      },
      semanticTokens = false,
      staticcheck = false,
      gofumpt = false,
    },
  },
  init_options = {
    directoryFilters = { "-.task", "-node_modules" },
    -- memoryMode = "DegradeClosed",
    -- memoryMode = "Normal",
  },
  single_file_support = true,
  root_dir = lsp_config.util.root_pattern("go.mod"),
})

lsp_config.terraformls.setup({
  cmd = lsp_servers.terraform,
  filetypes = { "terraform" },
  on_attach = on_attach,
  root_dir = lsp_config.util.root_pattern(".git", ".terraform"),
})
