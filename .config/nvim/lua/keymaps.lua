local maps = require("lib.mapping")
-- print(vim.inspect(maps));

-- resets
maps["nnoremap"]("s", "")
maps["vnoremap"]("s", "")
maps["nnoremap"]("q", "")
maps["snoremap"]("q", "")
maps["nnoremap"]("Q", "")
maps["vnoremap"]("Q", "")

-- ; to :
maps["nnoremap"](";", ":")
maps["vnoremap"](";", ":")

-- j/k to virtual gj/gk
maps["nnoremap"]("j", "gj")
maps["nnoremap"]("k", "gk")

-- copy to system clipboard
maps["nnoremap"]("cc", '"+y')
maps["vnoremap"]("cc", '"+y')

-- toggle fullscreen
maps["nnoremap"]("mm", ":Max<CR>")



-- cancel highlighting
maps["nnoremap"]("<BS>", ":set nohls<CR>")

-- Resizing Splits
maps["nnoremap"]("<C-M-Right>", ":vert resize +10<CR>")
maps["nnoremap"]("<C-M-Left>", ":vert resize -10<CR>")
maps["nnoremap"]("<C-M-Up>", ":resize +4<CR>")
maps["nnoremap"]("<C-M-Down>", ":resize -4<CR>")
maps["nnoremap"]("sy", ":vert resize +10<CR>")
maps["nnoremap"]("so", ":resize +4<CR>")


-- comment/uncomment
maps["nmap"]("s;", "gcc", {})
maps["vmap"]("s;", "gcc", {})

maps["tnoremap"]("<Esc>", "<C-\\><C-n>")

-- saving file
maps["nnoremap"]("ss", ":w<CR>")

-- file exporter
maps["nnoremap"]("s<Space>", ":NERDTreeToggle<CR>")


-- split navigation
maps["nnoremap"]("sh", "<C-w>h<CR>")
maps["nnoremap"]("sl", "<C-w>l<CR>")
maps["nnoremap"]("sj", "<C-w>j<CR>")
maps["nnoremap"]("sk", "<C-w>k<CR>")

-- buffer management
maps["nnoremap"]("sdb", ":BDelete this<CR>")
maps["nnoremap"]("sdo", ":BDelete other<CR>")
maps["nnoremap"]("sda", ":BDelete all<CR>")
maps["nnoremap"]("sdn", ":BDelete nameless<CR>")

maps["nnoremap"]("s[", ":bprev<CR>")
maps["nnoremap"]("s]", ":bnext<CR>")

-- Iterate Quickfix list
maps["nnoremap"]("q[", ":cprev<CR>")
maps["nnoremap"]("q]", ":cnext<CR>")
maps["nnoremap"]("qo", ":copen<CR>")
maps["nnoremap"]("qc", ":cclose<CR>")

-- making splits
maps["nnoremap"]("si", ":vsplit<CR>")
maps["nnoremap"]("sm", ":split<CR>")

-- file explorer | word grepper
maps["nnoremap"]("sf", ":lua require'plugins_dir.telescope'.find_files()<CR>")
maps["nnoremap"]("ff", ":lua require'plugins_dir.telescope'.grep()<CR>")

-- rename variable
maps["nnoremap"]("sr", ":lua vim.lsp.buf.rename()<CR>")

-- jump to next / prev error
maps["nnoremap"]("sn", ":lua vim.lsp.diagnostic.goto_next()<CR>")
maps["nnoremap"]("sp", ":lua vim.lsp.diagnostic.goto_prev()<CR>")

-- touuble toggle
maps["nnoremap"]("st", ":TroubleToggle<CR>")

-- LSP
maps["nnoremap"]("se", ":lua vim.diagnostic.open_float()<CR>")
maps["nnoremap"]("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")

maps["nnoremap"]("sb", ":Telescope buffers<CR>")
maps["nnoremap"]("gd", ":Telescope lsp_definitions<CR>")
maps["nnoremap"]("gr", ":Telescope lsp_references<CR>")
maps["nnoremap"]("gdd", ":Telescope lsp_document_diagnostics<CR>")
maps["nnoremap"]("gds", ":Telescope lsp_document_symbols<CR>")
maps["nnoremap"]("gwd", ":Telescope lsp_workspace_diagnostics<CR>")
maps["nnoremap"]("gws", ":Telescope lsp_workspace_symbols<CR>")

-- lsp code actions
maps["nnoremap"]("<M-CR>", ":Telescope lsp_code_actions<CR>")
maps["vnoremap"]("<M-CR>", ":Telescope lsp_code_actions<CR>")

-- rnvimr (file explorer)
maps["nnoremap"]("<M-o>", ":RnvimrToggle<CR>")
maps["tnoremap"]("<M-o>", "<C-\\><C-n>:RnvimrToggle<CR>")
-- because, rnvimr shits wqa
maps["cnoremap"]("wqa", "wa! | qa")

-- for tabs
maps["nnoremap"]("tn", ":tabnew <CR>")
maps["nnoremap"]("te", ":tabedit % <CR>")

-- [Source]: https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
-- Keep search results centred
maps["nnoremap"]("n", "nzzzv")
maps["nnoremap"]("N", "Nzzzv")
maps["nnoremap"]("J", "mzJ`z")

-- from:plugin / navigator.nvim'
vim.cmd([[let g:tmux_navigator_no_mappings = 1]])
maps["nnoremap"]("<M-h>", ":TmuxNavigateLeft<cr>")
maps["nnoremap"]("<M-l>", ":TmuxNavigateRight<cr>")
maps["nnoremap"]("<M-k>", ":TmuxNavigateUp<cr>")
maps["nnoremap"]("<M-j>", ":TmuxNavigateDown<cr>")

-- eslint format
maps["nnoremap"]("fp", ":Prettier<CR>")

function _G.NxtFormatMap()
  -- get matching root directory of lsp
  local lsp_root = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":h")
  -- print (lsp_root)
  if vim.bo.filetype == "javascript" or vim.bo.filetype == "javascriptreact" then
    maps["nnoremap"]("f;", ":!eslint_d --fix '%' <CR>|:e!<CR>")
    -- maps["nnoremap"]("f;", ":EslintFixAll<CR>")
  elseif vim.bo.filetype == "go" then
    maps["nnoremap"]("f;", ":!gofmt -w '%'<CR>|:e!<CR>")
  end
end

vim.cmd[[
 " autocmd! FileType javascript,javascriptreact,go :lua NxtFormatMap()
 autocmd! BufWinEnter *.js,*.jsx,*.go :lua NxtFormatMap()
]]

-- vimspector
vim.api.nvim_command("command! -nargs=0 Reload :luafile $XDG_CONFIG_HOME/nvim/init.lua")

vim.api.nvim_command("command! -nargs=0 DD :call vimspector#Launch()<CR>")
vim.api.nvim_command("command! -nargs=0 Dbp :call vimspector#ToggleBreakpoint()<CR>")
vim.api.nvim_command("command! -nargs=0 Dj :call vimspector#StepOver()<CR>")
vim.api.nvim_command("command! -nargs=0 Dk :call vimspector#StepOut()<CR>")
vim.api.nvim_command("command! -nargs=0 Dl :call vimspector#StepInto()<CR>")
vim.api.nvim_command("command! -nargs=0 Dr :call vimspector#Restart()<CR>")
vim.api.nvim_command("command! -nargs=0 De :call vimspector#Reset()<CR>")

vim.api.nvim_command("command! -nargs=0 Max :MaximizerToggle")

