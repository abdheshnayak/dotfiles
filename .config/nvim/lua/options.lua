local opt = vim.opt

opt.background = "dark"

opt.hidden = true
opt.autoread = true
opt.number = true

opt.scrolloff = 10
opt.fileformat = "unix"
opt.backspace = "indent,eol,start"

-- Persistent Undo
opt.undodir = vim.fn.stdpath("cache") .. "undodir"
opt.undofile = true

opt.switchbuf = "usetab,newtab"

-- Fast Scrolling
opt.ttimeoutlen = 10
opt.ttyfast = true
opt.lazyredraw = true

-- AutoWrap
opt.wrap = true

-- Always split in right and bottom
opt.splitright = true
opt.splitbelow = true

-- Term Gui Colors
opt.termguicolors = true

-- Completion PopUp Transparency
opt.wildoptions = "pum"
opt.pumblend = 9

-- Copy Previous Indentation
opt.smartindent = true
opt.copyindent = true

-- Completion, popup
opt.completeopt = "menuone,noinsert,noselect"

-- Tab and Spaces
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
