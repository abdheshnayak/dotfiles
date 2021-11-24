require("packer").startup(function()
  use("wbthomason/packer.nvim")

  -- Large fIles
  -- use("vim-scripts/LargeFile")

  -- back to where you left
  use("farmergreg/vim-lastplace")
  use("glepnir/dashboard-nvim")

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
  use({
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim",
  })
  use("drewtempelmeyer/palenight.vim")
  use("savq/melange")
  -- use("rmehri01/onenord.nvim")
  -- use("shaunsingh/nord.nvim")
  -- use("0xdefaced/nord.nvim")
  -- use("arcticicestudio/nord-vim")
  use("sainnhe/everforest")
  use("sainnhe/gruvbox-material")
  use("maaslalani/nordbuddy")
  use("sainnhe/sonokai")
  use("mhartington/oceanic-next")
  use("shaunsingh/solarized.nvim")
  use("EdenEast/nightfox.nvim")
  use("folke/tokyonight.nvim")
  use("bluz71/vim-nightfly-guicolors")
  use("Th3Whit3Wolf/one-nvim")
  use("NLKNguyen/papercolor-theme")

  use("norcalli/nvim-colorizer.lua")

  -- Motion
  use("bkad/CamelCaseMotion")
  use("chaoren/vim-wordmotion")
  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("mbbill/undotree")
  use("kevinhwang91/nvim-hlslens")
  use("mg979/vim-visual-multi")
  use("chrisbra/NrrwRgn")

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
  use("kevinhwang91/rnvimr")
  use("christoomey/vim-tmux-navigator")
  use("psliwka/vim-smoothie")

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use("folke/lsp-colors.nvim") --  better diagonstics colors
  use("hrsh7th/nvim-compe")
  use("onsails/lspkind-nvim")
  use("folke/lua-dev.nvim")
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
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/vim-vsnip-integ" },
      { "Saecki/crates.nvim" },
      { "f3fora/cmp-spell" },
    },
  })
  use({
    "andersevenrud/compe-tmux",
    branch = "cmp",
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/nvim-treesitter-refactor")
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
  use("famiu/bufdelete.nvim")

  -- navigator
  -- use({ "ray-x/navigator.lua", requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" } })

  -- debugging
  use("puremourning/vimspector")
  use("szw/vim-maximizer")

  -- dot-http
  use("nxtcoder17/vim-dot-http")

  -- async
  use("tpope/vim-dispatch")
end)

-- git signs
-- require('gitsigns').setup {
--   signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
--   numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
--   linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
--   word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
-- }

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

-- wilder
-- vim.call([[ wilder#setup({'modes': [':', '/', '?']}) ]])

vim.cmd([[
  let g:expand_region_text_objects = {
        \ 'iw'  :0,
        \ 'iW'  :0,
        \ 'i"'  :0,
        \ 'i''' :0,
        \ 'i]'  :1,
        \ 'ib'  :1,
        \ 'iB'  :1,
        \ 'il'  :1,
        \ 'ip'  :1,
        \ 'ie'  :0,
        \ }
]])

vim.cmd([[ map <C-w> <Plug>(expand_region_expand) ]])

vim.g.dashboard_default_executive = "telescope"

-- Glow.nvim
vim.g.glow_binary_path = vim.fn.stdpath("data") .. "bin"
vim.g.glow_border = "rounded"

-- large files

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
