vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.opt.foldminlines = 10
vim.opt.fillchars = "fold: "

local function lspBasedFolding()
  -- Tell the server the capability of foldingRange,
  -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require("lspconfig")[ls].setup({
      capabilities = capabilities,
      -- you can add other fields for setting up lsp server in this table
    })
  end
  require("ufo").setup()
end

local function tsBasedFolding()
  require("ufo").setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  })
end
