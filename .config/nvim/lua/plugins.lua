local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  local packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").startup(function()
  use("wbthomason/packer.nvim")

  -- Large fIles
  -- use("vim-scripts/LargeFile")

  -- back to where you left
  use("farmergreg/vim-lastplace")
  use("glepnir/dashboard-nvim")

  -- file explorer
  use("preservim/nerdtree")
  use("ryanoasis/vim-devicons")
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require'nvim-tree'.setup {} end
  -- }
  -- copilot
  use("github/copilot.vim")

  -- formatter prettier
  use("prettier/vim-prettier")

  -- syntax highlighting
  use("mboughaba/i3config.vim")
  use("lukas-reineke/indent-blankline.nvim")

  -- golang
  use({
    "crispgm/nvim-go",
    config = function()
      require("go").setup({
        lint_prompt_style = "vt",
      })
    end,
  })
  -- use({
  --   "ray-x/go.nvim",
  --   config = function()
  --     require("go").setup({})
  --   end,
  -- })

  -- todo tracking
  use("folke/todo-comments.nvim")

  -- auto-sessions
  use({
    "rmagatti/auto-session",
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
      require("auto-session").setup({
        log_level = "info",
        auto_session_enabled = true,
        auto_session_suppress_dirs = { "~/" },
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      })
    end,
  })

  use({
    "rmagatti/session-lens",
    config = function()
      require("session-lens").setup()
    end,
  })

  -- toggle term
  use{ "akinsho/toggleterm.nvim", config = function()
    require'toggleterm'.setup()
  end }

  -- AutoPairs
  use("windwp/nvim-autopairs")

  use("lewis6991/impatient.nvim")

  -- syntax
  use("sheerun/vim-polyglot")
  use("fladson/vim-kitty")
  use({ "ellisonleao/glow.nvim" })

  --  syntax specific
  -- use({"Jakski/vim-yaml", run = ":UpdateRemotePlugins"})

  -- color schemes
  use("folke/tokyonight.nvim")

  use("norcalli/nvim-colorizer.lua")

  -- Motion
  use("chaoren/vim-wordmotion")
  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("mbbill/undotree")
  use("kevinhwang91/nvim-hlslens")
  use("mg979/vim-visual-multi")
  use("chrisbra/NrrwRgn")

  -- kubernetes
  use("andrewstuart/vim-kubernetes")

  -- status line
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- coc lsp
  -- use {'neoclide/coc.nvim', branch = 'release'}
  use({ "junegunn/fzf", run = "./install --bin" })
  use({
    "ibhagwan/fzf-lua",
    requires = {
      "vijaymarupudi/nvim-fzf",
      "kyazdani42/nvim-web-devicons",
    },
  })

  -- file explorer
  use("kevinhwang91/rnvimr")
  use("christoomey/vim-tmux-navigator")
  use("psliwka/vim-smoothie")

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use("folke/lsp-colors.nvim") --  better diagonstics colors
  use("onsails/lspkind-nvim")
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp-status.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  -- use("/jose-elias-alvarez/null-ls.nvim")
  use("ray-x/lsp_signature.nvim")
  use("glepnir/lspsaga.nvim")

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Code Beauty
  use("mhartington/formatter.nvim")

  -- Buffer Management
  use({ "kevinhwang91/nvim-bqf", ft = "qf" })
  use("luukvbaal/stabilize.nvim")

  -- TextObj
  use("terryma/vim-expand-region")

  use("kana/vim-textobj-user")
  use("kana/vim-textobj-indent")
  use("kana/vim-textobj-line")
  use("kana/vim-textobj-entire")
  use("kana/vim-textobj-function")
  use("kana/vim-textobj-underscore")

  -- wild mode
  use({ "gelguy/wilder.nvim", run = ":UpdateRemotePlugins" })

  -- AutoCompletion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "ray-x/cmp-treesitter" },
      { "SirVer/ultisnips" },
      { "quangnguyen30192/cmp-nvim-ultisnips" },
      { "hrsh7th/nvim-cmp" },
      { "Saecki/crates.nvim" },
      { "f3fora/cmp-spell" },
      { "hrsh7th/cmp-copilot" },
    },
  })
  use({
    "andersevenrud/compe-tmux",
    branch = "cmp",
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- use("nvim-treesitter/nvim-treesitter-refactor")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- use("windwp/nvim-autopairs")
  use("p00f/nvim-ts-rainbow")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("andymass/vim-matchup")
  use("windwp/nvim-ts-autotag")

  -- Telescope
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-fzy-native.nvim")
  use("nvim-telescope/telescope-project.nvim")
  --
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Better profiling output for startup.
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  -- buffers
  -- use("famiu/bufdelete.nvim")
  use("kazhala/close-buffers.nvim")

  -- debugging
  use("puremourning/vimspector")
  use("szw/vim-maximizer")

  -- dot-http
  use("nxtcoder17/vim-dot-http")

  -- async
  use("tpope/vim-dispatch")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

require("colorizer").setup()

-- Extensions

------------------------\ Highlight Search
require("hlslens").setup({
  calm_down = true,
  nearest_only = true,
  nearest_float_when = "always",
})

-- stabilize.nvim
require("stabilize").setup()

-- require("indent_blankline").setup {
--     show_current_context = false,
-- }

-- wilder
-- vim.call([[ wilder#setup({'modes': [':', '/', '?']}) ]])

-- vim.cmd([[
--   let g:expand_region_text_objects = {
--         \ 'iw'  :0,
--         \ 'iW'  :0,
--         \ 'i"'  :0,
--         \ 'i''' :0,
--         \ 'i]'  :1,
--         \ 'ib'  :1,
--         \ 'iB'  :1,
--         \ 'il'  :1,
--         \ 'ip'  :1,
--         \ 'ie'  :0,
--         \ }
-- ]])
vim.cmd([[ map <C-w> <Plug>(expand_region_expand) ]])

vim.g.dashboard_default_executive = "telescope"

-- Glow.nvim
vim.g.glow_binary_path = vim.fn.stdpath("data") .. "bin"
vim.g.glow_border = "rounded"

-- large files no syntax hightlighting

-- vim.g.LargeFile = 0.25
vim.cmd([[

  " file is large from 10mb
let g:LargeFile = 1024 * 1024 * 2 / 10
augroup LargeFile 
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 " setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

]])
