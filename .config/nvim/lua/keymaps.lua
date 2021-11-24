local function mapHelper(mode, key, value, opts)
  vim.api.nvim_set_keymap(mode, key, value, opts)
end

local function map(key, value, opts)
  mapHelper("", key, value, opts)
end

local function unmap(mode, key)
  vim.api.nvim_del_keymap(mode, key)
end

local function nmap(key, value, opts)
  mapHelper("n", key, value, opts)
end
local function vmap(key, value, opts)
  mapHelper("v", key, value, opts)
end
local function cmap(key, value, opts)
  mapHelper("c", key, value, opts)
end
local function imap(key, value, opts)
  mapHelper("i", key, value, opts)
end

local function tmap(key, value, opts)
  mapHelper("t", key, value, opts)
end

local function omap(key, value, opts)
  mapHelper("o", key, value, opts)
end

local function xmap(key, value, opts)
  mapHelper("x", key, value, opts)
end

local function smap(key, value, opts)
  mapHelper("s", key, value, opts)
end


local globalOpts = { noremap = true, silent = true }

local function nnoremap(key, value)
  nmap(key, value, globalOpts)
end
local function vnoremap(key, value)
  vmap(key, value, globalOpts)
end
local function cnoremap(key, value)
  cmap(key, value, globalOpts)
end
local function tnoremap(key, value)
  tmap(key, value, globalOpts)
end
local function inoremap(key, value)
  imap(key, value, { noremap = true, silent = true, expr = true })
end

-- Commands
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

--  Close All Buffers but current one
vim.api.nvim_command("command! BufOnly execute '%bdelete|edit #'")


-- keymappings

vim.g.mapleader = "c"

tnoremap("<Esc>", "<C-\\><C-n>")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("Q", "")
nnoremap("s", "")
vnoremap("s", "")
-- nnoremap("f", "")
-- vnoremap("f", "")

-- Removing buffers
nnoremap("fd", ":bdelete<CR>")
nnoremap("fdd", ":bwipeout<CR>")

-- nnoremap("ff", ":lua require'plugins_dir.telescope'.live_grep({use_regex=true})<CR>")
nnoremap("ff", ":lua require'plugins_dir.telescope'.grep()<CR>")

nnoremap("<BS>", ":nohlsearch<CR>")
nnoremap("Y", '"+y')
vnoremap("Y", '"+y')

nnoremap("cc", '"+y')
vnoremap("cc", '"+y')

nnoremap(";", ":")
vnoremap(";", ":")

nmap("ss", ":up<CR>", {})

nnoremap("sh", "<C-w>h<CR>")
nnoremap("sl", "<C-w>l<CR>")
nnoremap("sj", "<C-w>j<CR>")
nnoremap("sk", "<C-w>k<CR>")

nnoremap("si", ":vsplit<CR>")
nnoremap("sm", ":split<CR>")

nnoremap("sf", ":lua require'plugins_dir.telescope'.find_files()<CR>")
nnoremap("ff", ":lua require'plugins_dir.telescope'.grep()<CR>")
nnoremap("sb", ":Telescope buffers<CR>")

nnoremap("sn", ":bnext<CR>")

nnoremap("f;", ":!eslint_d --fix '%' <CR>|:e!<CR>")

-- Trouble nvim toggle
nnoremap("st", ":TroubleToggle<CR>")

-- [Source]: https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
-- Keep search results centred
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- Resizing Splits
nnoremap("<C-S-Right>", ":vert resize +10<CR>")
nnoremap("<C-S-Left>", ":vert resize -10<CR>")
nnoremap("<C-S-Up>", ":resize +10<CR>")
nnoremap("<C-S-Down>", ":resize -10<CR>")

-- rnvimr
nnoremap("<M-o>", ":RnvimrToggle<CR>")
tnoremap("<M-o>", "<C-\\><C-n>:RnvimrToggle<CR>")

-- because, rnvimr shits wqa
cnoremap("wqa", "wa! | qa")

-- from:plugin / navigator.nvim'
vim.cmd([[let g:tmux_navigator_no_mappings = 1]])

nnoremap("<M-h>", ":TmuxNavigateLeft<cr>")
nnoremap("<M-l>", ":TmuxNavigateRight<cr>")
nnoremap("<M-k>", ":TmuxNavigateUp<cr>")
nnoremap("<M-j>", ":TmuxNavigateDown<cr>")

-- CoC based
-- vim.cmd([[cabbrev('OR', ':CocCommand editor.action.organizeImport')]])
--
-- comment uncomment
nmap("s;", "gcc", {})
vmap("s;", "gcc", {})

-- nvim lsp
nnoremap("gd", ":lua require'telescope.builtin'.lsp_definitions()<CR>")
nnoremap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")

nnoremap("gr", ":lua require'telescope.builtin'.lsp_references()<CR>")
nnoremap("fl", ":lua require'telescope.builtin'.lsp_document_diagnostics()<CR>")
nnoremap("fn", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")

-- These mappings could get very slow, so must use `set timeoutlen=200`

nnoremap("se", "<Cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>")
nnoremap("<leader>fs", ":lua vim.lsp.buf.signature_help()<CR>")

nnoremap("sr", "<Cmd>lua require('lspsaga.rename').rename()<CR>")

nnoremap("s,", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
nnoremap("s.", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")

vim.cmd([[ cabbrev http :DotHttp<CR> ]])

-- cnoremap("qq", ":exit<CR>")

nnoremap("<leader>dd", ":bwipeout<CR>")

nnoremap("<M-CR>", ":lua require'telescope.builtin'.lsp_code_actions()<CR>")
vnoremap("<M-CR>", ":lua require'telescope.builtin'.lsp_range_code_actions()<CR>")

vim.g.wordmotion_nomap = 1
map('w', '<Plug>WordMotion_w', {})
map('b', '<Plug>WordMotion_b', {})
map('e', '<Plug>WordMotion_e', {})
map('aw', '<Plug>WordMotion_aw', {})
map('iw', '<Plug>WordMotion_iw', {})
cmap('<C-R><C-W>', '<Plug>WordMotion_<C-R><C-W>', {})
---- term open

function termInBufferDir()
  local dir = vim.fn.expand('%:h')
end

-- nnoremap('ct', string.format(':call termopen("cd %s && %s") <CR>|set ft=terminal', vim.fn.expand('%:h'), 'zsh'))
