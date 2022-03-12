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
	-- for faster neovim

-- dim unused variables
	-- use {
	-- 	"narutoxy/dim.lua",
	-- 	requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
	-- 	config = function()
	-- 		require('dim').setup({})
	-- 	end
	-- }

	use("lewis6991/impatient.nvim")

	use({
		"nathom/filetype.nvim",
		config = function()
			vim.g.did_load_filetypes = 1
		end,
	})

	use({ "caenrique/nvim-toggle-terminal", event = "BufEnter" })
  use {'is0n/fm-nvim'}

	use({
		"antoinemadec/FixCursorHold.nvim",
	})

	use("wbthomason/packer.nvim")

	-- osc copy
	use("ojroques/vim-oscyank")

	-- lsp symbols
	-- use("simrat39/symbols-outline.nvim")

	-- back to where you left
	use("farmergreg/vim-lastplace")

	-- search code
	use("dyng/ctrlsf.vim")
	use("nvim-pack/nvim-spectre")

	-- debugger
	-- use("Pocco81/DAPInstall.nvim")
	-- use({
	-- 	"mfussenegger/nvim-dap",
	-- 	ft = { "javascript" },
	-- 	requires = {
	-- 		{ "rcarriga/nvim-dap-ui", ft = { "javascript" }, after = "nvim-dap" },
	-- 		{
	-- 			"theHamsta/nvim-dap-virtual-text",
	-- 			ft = { "javascript" },
	-- 			after = "nvim-dap",
	-- 			config = function()
	-- 				vim.g.dap_virtual_text = true
	-- 				require("nvim-dap-virtual-text").setup()
	-- 			end,
	-- 		},
	-- 	},
	-- })

	-- copilot
	use({ "github/copilot.vim", event = "InsertEnter" })

	-- markdown
	use({ "davidgranstrom/nvim-markdown-preview", ft = "markdown" })

	-- syntax highlighting
	use({ "mboughaba/i3config.vim", ft = "i3config" })

	use({ "lukas-reineke/indent-blankline.nvim", 
		event = "BufRead", 
		config = function()
			require("plugins_dir.indent-blankline")
	  end 
	})

	--  align
	use({ "godlygeek/tabular", event = "BufRead" })

	-- helm
	use({ "towolf/vim-helm", ft = "helm" })

	-- golang
	use({
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup()
		end,
	})

	-- commenting
	-- use({ 'b3nj5m1n/kommentary' })
	-- use "terrortylor/nvim-comment"

  -- require('nvim_comment').setup()

	-- todo tracking
	use({
		"folke/todo-comments.nvim",
		event = "BufReadPre",
		config = function()
			require("todo-comments").setup()
		end,
	})

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

	-- tab helpers
	use({
		"nanozuki/tabby.nvim",
		event = "VimEnter",
		config = function()
			require("tabby").setup()
		end,
	})

 	-- vim-airline
  use({"windwp/nvim-ts-autotag"})

  -- use({'JoosepAlviste/nvim-ts-context-commentstring'}) 

	-- AutoPairs
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		after = "nvim-cmp",
		config = function()
			require("nvim-autopairs").setup({})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	})

	-- syntax
	use{ "sheerun/vim-polyglot" }
	use({ "fladson/vim-kitty", ft = "kitty" })
	use({
		"ellisonleao/glow.nvim",
		ft = "markdown",
		config = function()
			vim.g.glow_binary_path = vim.fn.stdpath("data") .. "bin"
			vim.g.glow_border = "rounded"
		end,
	})

	-- color schemes
	use({
		"folke/tokyonight.nvim",
		{ "rebelot/kanagawa.nvim" },
	})

	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Motion
	use({ "chaoren/vim-wordmotion", event = "InsertEnter" })
	use({ "tpope/vim-surround", event = "InsertEnter" })
	-- use("mbbill/undotree")
	use({
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPost",
		config = function()
			require("hlslens").setup({
				calm_down = true,
				nearest_only = true,
				nearest_float_when = "always",
			})
		end,
	})
	use({ "mg979/vim-visual-multi", event = "BufReadPost" })
	use({ "chrisbra/NrrwRgn", event = "BufReadPost" })

	-- kubernetes
	use({ "andrewstuart/vim-kubernetes", ft = "yaml" })

	-- use({
	--   "kyazdani42/nvim-web-devicons",
	--   event = "BufEnter",
	-- })

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
			{ "arkav/lualine-lsp-progress" },
		},
		event = "BufEnter",
		config = function()
			require("plugins_dir.lualine")
		end,
	})

	use({
		"ibhagwan/fzf-lua",
		requires = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
			{ "junegunn/fzf", run = "./install --bin" },
		},
	})

	-- file explorer
	use({ "kevinhwang91/rnvimr", commit = "e93671b4ea8" }) -- something broke in latest, i could not do splits

	-- tmux
	use("christoomey/vim-tmux-navigator")
	use("psliwka/vim-smoothie")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		event = "BufReadPost",
		config = function()
			require("lsp")
		end,
		requires = {
			{ "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" },
			-- {
			-- 	"jose-elias-alvarez/null-ls.nvim",
			-- 	after = "nvim-lspconfig",
			-- 	config = function()
			-- 		require("plugins_dir.null-ls")
			-- 	end,
			-- },
			{ "folke/lsp-colors.nvim", after = "nvim-lspconfig" },
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		commit = "4e4b58f8e994",
		event = "BufEnter",
		config = function()
			require("plugins_dir.treesitter")
		end,
		requires = {
			{ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
			{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
			{ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				after = "nvim-treesitter",
				-- ft = { "javascript", "javascriptreact" },
			},
			{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter", event = "BufReadPre" },
			-- {
			-- 	"numToStr/Comment.nvim",
			-- 	after = "nvim-treesitter",
			-- 	event = "BufReadPost",
			-- 	config = function()
			-- 		require("plugins_dir.comment-nvim")
			-- 	end,
			-- },
		},
	})

	-- indent highlighting
	-- use "lukas-reineke/indent-blankline.nvim"

	use("tpope/vim-commentary")

	-- AutoCompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "ray-x/cmp-treesitter" },
			{ "Saecki/crates.nvim" },
      { "dcampos/cmp-snippy" },
			{ "f3fora/cmp-spell" },
			{
				"hrsh7th/cmp-copilot",
				config = function()
					require("plugins_dir.copilot")
				end,
			},
		},
		-- event = "InsertEnter",
		event = "BufRead",
		config = function()
			require("plugins_dir.nvim-cmp")
		end,
	})

  use({ 
    'dcampos/nvim-snippy', 
    event="InsertEnter",
    config = function() 
      require("snippy").setup({})
    end
  })

	-- use("nvim-lua/lsp-status.nvim")
	-- use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- use("glepnir/lspsaga.nvim")

	-- use({
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- })

	-- use({
	--   "folke/trouble.nvim",
	--   requires = "kyazdani42/nvim-web-devicons",
	-- })

	-- Code Beauty
	-- use("mhartington/formatter.nvim")

	-- Buffer Management
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	-- use({
	-- 	"luukvbaal/stabilize.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("stabilize").setup()
	-- 	end,
	-- })

	-- TextObj
	-- use("terryma/vim-expand-region")
	-- use("kana/vim-textobj-user")
	-- use("kana/vim-textobj-indent")
	-- use("kana/vim-textobj-line")
	-- use("kana/vim-textobj-entire")
	-- use("kana/vim-textobj-function")
	-- use("kana/vim-textobj-underscore")

	-- wild mode
	use({ "gelguy/wilder.nvim", run = ":UpdateRemotePlugins", event = "VimEnter" })

	use("andymass/vim-matchup")

	use("numToStr/FTerm.nvim")

	-- Telescope
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins_dir.telescope")
		end,
		requires = {
			{ "nvim-telescope/telescope-project.nvim" },
			-- { "nvim-telescope/telescope-dap.nvim", after = "nvim-dap", ft = { "javascript" } },
		},
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- Better profiling output for startup.
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	-- buffers
	use("kazhala/close-buffers.nvim")

	-- maximise vim split window
	use("szw/vim-maximizer")

	-- dot-http
	-- use({ "nxtcoder17/vim-dot-http", ft = "http" })

	-- async
	use("tpope/vim-dispatch")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
