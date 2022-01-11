local opt = vim.opt

-- cause i always use a dark variant theme
opt.background = "dark"

-- highlight current line
-- opt.cursorline = true

-- silently move between windows
opt.hidden = true

-- better response to file changes from external effects
opt.autoread = true

-- line numbers
opt.number = true

-- line offsets while vertical scrolling
opt.scrolloff = 10

opt.fileformat = "unix"

-- make backspace delete everything
opt.backspace = "indent,eol,start"

-- Persistent Undo
opt.undodir = vim.fn.stdpath("cache") .. "undodir"
opt.undofile = true

-- rules while swithching to a buffer
opt.switchbuf = "useopen,usetab,newtab"

-- Fast Scrolling
opt.ttimeoutlen = 10
opt.timeoutlen = 500
opt.ttyfast = true
opt.updatetime = 50
opt.lazyredraw = true

-- no awkward horizontal jumping (for linters, git signs and lsp symbols)
opt.signcolumn = "yes:2"

-- AutoWrap
opt.wrap = true

-- Always split in right and bottom
opt.splitright = true
opt.splitbelow = true

-- Term Gui Colors
opt.termguicolors = true

-- wild menu
opt.wildmenu = true
opt.wildmode = "full"
opt.wildignore = "*/node_modules/*,*/.git/*,.next"

-- Completion PopUp Transparency
opt.wildoptions = "pum"
opt.pumblend = 9

-- Copy Previous Indentation
opt.smartindent = true
opt.copyindent = true
opt.autoindent = true

-- Completion, popup
opt.completeopt = "menu,menuone,noinsert,noselect"

-- Tab and Spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2 -- spaces per tab when using >> or <<
opt.expandtab = true -- expand tabs into spaces
opt.autoindent = true
opt.smarttab = true
opt.shiftround = true

-- search options
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = true

-- no swap file
opt.swapfile = false

-- replace
opt.inccommand = "split" -- shows live incremental status of substitution in split buffer

opt.mouse = "a"

vim.cmd([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
augroup end
]])

-- don't auto commenting new lines
vim.cmd([[au! BufEnter * set fo-=c fo-=r fo-=o]])

vim.g.matchup_matchparen_status_offscreen = 0
vim.g.matchup_matchparen_pumvisible = 0
vim.g.matchup_matchparen_nomode = "ivV"
vim.g.matchup_surround_enabled = 1

-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1

  -- local start_char = " ⚡ "
  -- local start_char = " 🪅 "
  local start_char = " 😎 "
  local fill_char = " +--+ "

  local other_offsets = 12
  local right_padding = 10
  local first_stop = vim.fn.winwidth(0) - #line - other_offsets - right_padding - #start_char - #line / 3
  return start_char
    .. line
    .. (" "):rep(#line / 3)
    .. fill_char:rep(first_stop / #fill_char)
    .. string.format("[ %2s lines ]", line_count)
    .. (" "):rep(right_padding)
end

vim.opt.foldtext = "v:lua.custom_fold_text()"
