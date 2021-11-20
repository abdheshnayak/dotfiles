local function map(mode, key, value, opts)
  vim.api.nvim_set_keymap(mode, key, value, opts)
end

local function nmap(key, value, opts)
  map("n", key, value, opts)
end
local function vmap(key, value, opts)
  map("v", key, value, opts)
end
local function cmap(key, value, opts)
  map("c", key, value, opts)
end
local function imap(key, value, opts)
  map("i", key, value, opts)
end
local function tmap(key, value, opts)
  map("t", key, value, opts)
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

tnoremap("<Esc>", "<C-\\><C-n>")

nnoremap("Q", "")
nnoremap("s", "")

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

nnoremap("sf", ":Telescope find_files<CR>")

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

-- Code Related
nnoremap("s;", ":!eslint_d --fix % <CR><CR> | :e!")
