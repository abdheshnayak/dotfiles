local opt = vim.opt

-- cause i always use a dark variant theme
opt.background = "dark"

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

-- global statusline
opt.laststatus = 3

-- stop resizing on closing splits
-- opt.equalalways = false

-- Fast Scrolling
opt.ttimeoutlen = 10
opt.timeoutlen = 500
opt.ttyfast = true
opt.updatetime = 50
opt.lazyredraw = false

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

opt.wildignore:append("node_modules", ".git", ".next", "build", "dist")

-- Completion PopUp Transparency
opt.wildoptions = "pum"
opt.pumblend = 9
opt.pumheight = 20

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

-- gui
opt.guifont = "Operator Mono Lig Medium:h13.5"
opt.linespace = 4
opt.guifontwide = "FiraCode Nerd Font Medium:h13"

opt.mouse = "a"

-- don't auto commenting new lines
vim.cmd([[au! BufEnter * set fo-=c fo-=r fo-=o]])

vim.g.matchup_matchparen_status_offscreen = 0
vim.g.matchup_matchparen_pumvisible = 0
vim.g.matchup_matchparen_nomode = "ivV"
vim.g.matchup_surround_enabled = 1

-- opt.foldcolumn = "1"
-- opt.foldmethod = "marker"
opt.foldmethod = "manual"
opt.foldmarker = "👉,👈"

function _G.custom_fold_text() -- 👉
	local line = vim.fn.getline(vim.v.foldstart)
	local nextLine = vim.fn.getline(vim.v.foldstart + 1)
	local line_count = vim.v.foldend - vim.v.foldstart + 1

	local start_char = " ✂️ "
	local fill_char = " • "

	local showLine = line
	if #line < 25 then
		showLine = showLine .. nextLine:sub(1, math.min(20, #nextLine))
	end

	local ds = start_char .. string.format("[%3s lines] | ", line_count) .. showLine .. " "

	return ds .. fill_char:rep(math.max(vim.fn.winwidth(0) - #ds - (#fill_char - 1) - 3, 0))
end -- 👈

opt.foldtext = "v:lua.custom_fold_text()"
