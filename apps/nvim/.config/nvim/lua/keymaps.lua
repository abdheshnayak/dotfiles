local maps = require("lib.mapping")

local M = {}

local function reset()
  maps["nnoremap"]("S", "")
  maps["nnoremap"]("S", "")
  maps["nnoremap"]("s", "")
  maps["vnoremap"]("s", "")

  maps["nnoremap"]("H", "")
  maps["nnoremap"]("M", "")
  maps["nnoremap"]("L", "")

  maps["nnoremap"]("Q", "")
  maps["vnoremap"]("Q", "")

  maps["nnoremap"]("'", "")

  maps["nnoremap"]("<C-.>", "")
end

reset()

-- resets
-- ; to :
maps["nnoremap"](";", ":")
maps["vnoremap"](";", ":")

vim.g.mapleader = "'"

-- j/k to virtual gj/gk
maps["nnoremap"]("j", "gj")
maps["nnoremap"]("k", "gk")

-- copy to system clipboard
maps["nnoremap"]("cc", '"+y')
maps["vnoremap"]("cc", '"+y')

maps["vnoremap"]("scc", ":OSCYank<CR>")

-- cancel highlighting
maps["nnoremap"]("<BS>", ":set nohls <CR>|:HlSearchLensToggle <CR>|:HlSearchLensToggle <CR>")

-- Resizing Splits
maps["nnoremap"]("<C-M-Right>", ":vert resize +10<CR>")
maps["nnoremap"]("<C-M-Left>", ":vert resize -10<CR>")
maps["nnoremap"]("<C-M-Up>", ":resize +10<CR>")
maps["nnoremap"]("<C-M-Down>", ":resize -10<CR>")

-- comment/uncomment
maps["nmap"]("s;", "gcc", {})
maps["vmap"]("s;", "gcc", {})

maps["tnoremap"]("<Esc>", "<C-\\><C-n>")

-- saving file
maps["nnoremap"]("ss", ":w<CR>")

-- minimize maximize
maps["nnoremap"]("mm", ":MaximizerToggle<CR>")

-- split navigation
maps["nnoremap"]("sh", "<C-w>h<CR>")
maps["nnoremap"]("sl", "<C-w>l<CR>")
maps["nnoremap"]("sj", "<C-w>j<CR>")
maps["nnoremap"]("sk", "<C-w>k<CR>")

-- buffer management
maps["nnoremap"]("sdb", ":BDelete this<CR>")
maps["nnoremap"]("sdo", ":BDelete other<CR>")
maps["nnoremap"]("sda", ":tabc<CR>")
maps["nnoremap"]("sdn", ":BDelete nameless<CR>")

-- Debugging
-- maps["nnoremap"]("qt", ":Telescope dap configurations<CR>")
-- maps["nnoremap"]("qq", ":Telescope dap commands<CR>")

-- Iterate Quickfix list
maps["nnoremap"]("s[", ":cprev<CR>")
maps["nnoremap"]("s]", ":cnext<CR>")
maps["nnoremap"]("qo", ":copen<CR>")
maps["nnoremap"]("qc", ":cclose<CR>")

-- maps['nnoremap']('tt', ':ToggleTerm<CR>')
maps["nnoremap"]("tt", ":ToggleTerm<CR>")

-- making splits
maps["nnoremap"]("si", ":vsplit<CR>")
maps["nnoremap"]("sm", ":split<CR>")

-- vim test
-- maps["nnoremap"]("st", ":lua require'lsp.goimpl'.run()<CR>")

-- file explorer | word grepper
maps["nnoremap"]("sf", ":Telescope find_files<CR>")
maps["nnoremap"]("ff", ":lua require'plugins_dir.telescope'.grep()<CR>")

local function lspNative()
  -- rename variable
  maps["nnoremap"]("sr", ":lua vim.lsp.buf.rename()<CR>")
  -- maps["nnoremap"]("sr", "<cmd>Lspsaga rename<cr>")

  -- jump to next / prev error
  maps["nnoremap"]("sn", ":lua vim.diagnostic.goto_next({ severity = 'error' })<CR>")
  maps["nnoremap"]("sp", ":lua vim.diagnostic.goto_prev({ severity = 'error'})<CR>")

  --show line diagnositcs
  maps["nnoremap"]("se", ":lua vim.diagnostic.open_float()<CR>")

  -- lsp formatting
  maps['nnoremap']('f;', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  maps["nnoremap"]("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
  maps["inoremap"]("<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")

  -- code actions
  maps["nnoremap"]("<M-CR>", ":Telescope lsp_code_actions<CR>")
  maps["vnoremap"]("<M-CR>", ":Telescope lsp_code_actions<CR>")

  -- formatting
  -- maps["nnoremap"]("f;", ":lua vim.lsp.buf.formatting()<CR>")

  -- commands
  maps["nnoremap"]("gd", ":Telescope lsp_definitions<CR>")
  maps["nnoremap"]("gr", ":Telescope lsp_references<CR>")
  maps["nnoremap"]("gi", ":Telescope lsp_implementations<CR>")
  maps["nnoremap"]("gdd", ":Telescope lsp_document_diagnostics<CR>")
  maps["nnoremap"]("gds", ":Telescope lsp_document_symbols<CR>")
  maps["nnoremap"]("gwd", ":Telescope lsp_workspace_diagnostics<CR>")
  maps["nnoremap"]("gws", ":Telescope lsp_workspace_symbols<CR>")
end

lspNative()

-- function _G.CodeFormatting()
--   maps["nmap"]("f;", "")
--   -- formatting
--   if vim.bo.filetype == "lua" then
--     maps["nmap"]("f;", "<cmd>!stylua --indent-width 2 --indent-type Spaces %<CR> <bar> <cmd>e!<CR>")
--     return
--   end

--   if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "javascriptreact" then
--     maps["nmap"]("f;", ":lua vim.lsp.buf.formatting()<CR>")
--     return
--   end

--   if vim.bo.filetype == "sh" then
--     -- maps["nmap"]("f;", ":!shfmt -i 2 -w -ci '%' <CR>|:e!<CR>")
--     maps["nmap"]("f;", "<cmd>!shfmt -i 2 -w -ci '%' <CR> <bar> <cmd>e!<CR>")
--     return
--   end

--   if vim.bo.filetype == "go" then
--     maps["nmap"]("f;", ":!gofmt -w '%'<CR>|:e!<CR>")
--     return
--   end

--   if vim.bo.filetype == "make" then
--     maps["nmap"]("f;", "")
--     return
--   end
-- end

-- vim.api.nvim_create_autocmd("BufReadPre", {
--   pattern = "*",
--   callback = _G.CodeFormatting,
-- })

local function withFuzzyFinders()
  maps["nnoremap"]("<leader>f", "<cmd>:Telescope current_buffer_fuzzy_find<CR>")
  maps["nnoremap"]("sb", "<cmd>Telescope buffers<CR>")
end

withFuzzyFinders()

-- rnvimr (file explorer)
maps["nnoremap"]("<M-o>", ":RnvimrToggle<CR>")
maps["tnoremap"]("<M-o>", "<C-\\><C-n>:RnvimrToggle<CR>")
-- because, rnvimr shits wqa
maps["cnoremap"]("wqa", "wa! | qa")

-- for tabs
maps["nnoremap"]("tn", "<cmd>tabnew<CR>")
maps["nnoremap"]("te", "<cmd>tabedit % |:windo tcd " .. vim.g.root_dir .. "<CR>")
maps["nnoremap"]("tl", ":lua require('plugins_dir.telescope').tabs()<CR>")

-- [Source]: https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
-- Keep search results centred
maps["nnoremap"]("n", "nzzzv")
maps["nnoremap"]("N", "Nzzzv")
maps["nnoremap"]("J", "mzJ`z")

-- from:plugin / navigator.nvim
vim.g.tmux_navigator_no_mappings = 1
maps["nnoremap"]("<M-h>", ":TmuxNavigateLeft<cr>")
maps["nnoremap"]("<M-l>", ":TmuxNavigateRight<cr>")
maps["nnoremap"]("<M-k>", ":TmuxNavigateUp<cr>")
maps["nnoremap"]("<M-j>", ":TmuxNavigateDown<cr>")

-- lsp

vim.cmd("command! -nargs=0 Root execute 'windo tcd g:root_dir'")
vim.cmd("command! -nargs=1 Cd execute 'windo tcd <f-args> <CR>'")

vim.cmd [[ command! -nargs=0 GoImplement  lua require'lsp.goimpl'.run()<CR> ]]



-- gql

-- vim.cmd [[ command! -nargs=0 Gql  execute 'vne | setlocal buftype=nofile | setlocal bufhidden=hide | setlocal noswapfile | set ft=json | r! node --es-module-specifier-resolution=node /home/nxtcoder17/workspace/nxtcoder17/graph-cli/src/index.js' . ' '. expand('%:p') . ' gqlenv.json'. ' '. line('.') ]]

-- function _G.NxtFormatMap()
--   if vim.bo.filetype == "sh" then
--     maps["nnoremap"]("f;", ":!shfmt -i 2 -w -ci '%' <CR>|:e!<CR>")
--   elseif vim.bo.filetype == "javascript" then
--     -- maps["nnoremap"]("f;", ":!eslint_d --fix '%' <CR>|:e!<CR>")
--     maps["nnoremap"]("f;", ":EslintFixAll<CR>")
--   elseif vim.bo.filetype == "go" then
--     maps["nnoremap"]("f;", ":!gofmt -w '%'<CR>|:e!<CR>")
--   elseif vim.bo.filetype == "make" then
--     maps["nnoremap"]("f;", nil)
--   end
-- end

-- vim.cmd([[
--  autocmd! FileType sh,javascript,javascriptreact,go :lua NxtFormatMap()
-- ]])
