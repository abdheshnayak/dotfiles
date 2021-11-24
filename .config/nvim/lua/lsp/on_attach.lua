-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...)
--     vim.api.nvim_buf_set_keymap(bufnr, ...)
--   end
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end

--   if client.config.flags then
--     client.config.flags.allow_incremental_sync = true
--   end
--   client.resolved_capabilities.document_formatting = false

--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

--   local opts = { noremap = true, silent = true }

--   -- Mappings.
--   buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   buf_set_keymap("n", "<M-CR>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()CR>", opts)
--   buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--   buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
--   buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
--   buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
--   buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
--   buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
--   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
--   buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
--   buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
--   buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

--   -- Set some keybinds conditional on server capabilities
--   if client.resolved_capabilities.document_formatting then
--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--   elseif client.resolved_capabilities.document_range_formatting then
--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--   end

--   -- Set autocommands conditional on server_capabilities
--   -- autocmd! * <buffer>
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       hi LspReferenceRead gui=bold guibg=#5a6863
--       hi LspReferenceText gui=bold guibg=#5a6863
--       hi LspReferenceWrite gui=bold guibg=#5a6863

--       hi! LspDiagnosticsVirtualTextError guifg=#cc8b9d  guibg=None  gui=None
--       hi! LspDiagnosticsVirtualTextWarning guifg=#e3ca7f  guibg=None  gui=None
--       hi! LspDiagnosticsVirtualTextInformation guifg=#a6eb91  guibg=None  gui=None
--       hi! LspDiagnosticsVirtualTextHint guifg=#617cc2 guibg=None  gui=None

--       augroup lsp_document_highlight
--         autocmd!
--         autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
--         autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

-- return on_attach

local on_attach = function(client, bufnr)
  local function bmap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function bopts(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- default opts
  local opts = { noremap = true, silent = true }

  -- bmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- bmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

return on_attach
