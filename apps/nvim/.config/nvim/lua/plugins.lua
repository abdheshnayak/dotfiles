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

local packer = require("packer")

local events = {
	BufReadPost = "BufReadPost",
	BufReadPre = "BufReadPre",
	BufEnter = "BufEnter",
	InsertEnter = "InsertEnter",
	VimEnter = "VimEnter",
}

local FileTypes = {
	javscript = { "javascript", "typescript" },
	react = { "javascriptreact", "typescriptreact" },
	javascriptreact = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
}

local function withLsp()
	local first = "nvim-lspconfig"
	use({
		"neovim/nvim-lspconfig",
		event = events.BufReadPost,
		config = function()
			require("lsp")
		end,
		requires = {
			{ "williamboman/nvim-lsp-installer", after = first },
			{ "folke/lsp-colors.nvim", after = first },
		},
	})
end

local function withTS()
	local first = "nvim-treesitter"
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufEnter",
		config = function()
			require("plugins_dir.treesitter")
		end,
		requires = {
			{ "MaxMEllon/vim-jsx-pretty", event = events.BufEnter, ft = FileTypes.react },
			{ "nvim-treesitter/nvim-treesitter-refactor", after = first },
			{ "nvim-treesitter/nvim-treesitter-textobjects", after = first },
			-- { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
			{ "andymass/vim-matchup", event = events.VimEnter },
			{ "windwp/nvim-ts-autotag", event = events.BufReadPre, after = first },
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				after = first,
				ft = FileTypes.javascriptreact,
			},
			{
				"p00f/nvim-ts-rainbow",
				commit = "7e1af3e61b8f529031",
				event = events.BufReadPre,
			},
			{ "andymass/vim-matchup", after = first },
			{ "nvim-treesitter/playground", after = first },
		},
	})
end

local function withTelescope()
	local first = "telescope.nvim"
	use({
		"nvim-telescope/telescope.nvim",
		-- event = "VimEnter",
		config = function()
			require("plugins_dir.telescope")
		end,
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-symbols.nvim" },
			{
				"nvim-telescope/telescope-frecency.nvim",
				config = function()
					require("telescope").load_extension("frecency")
				end,
				requires = { "tami5/sqlite.lua" },
			},
		},
	})
end

local function withCodingSetup()
	-- syntax highlighting
	use({ "mboughaba/i3config.vim", ft = "i3config" })
	use({ "fladson/vim-kitty", ft = "kitty" })
	use({
		"sheerun/vim-polyglot",
		config = function()
			-- vim.g.polyglot_disabled = { "go" }
		end,
	})

	use({
		"nxtcoder17/graphql-cli",
		run = "pnpm i",
		config = function()
			require("graphql-cli").setup({
				command = "Gql",
				envFile = function()
					return string.format("%s/%s", vim.env.PWD, ".tools/gqlenv.json")
				end,
			})
		end,
	})

	-- language specific
	-- INFO: for go1.18 with generic types, comment ERROR in treesitter query cause it messed up the colorscheme
	-- INFO: should not cause any issue, as lsp would throw error anyway when there is an error
	use({
		"ray-x/go.nvim",
		event = events.BufReadPost,
		ft = "go",
		config = function()
			require("go").setup()
		end,
	})


	-- linters
	use({
		"jose-elias-alvarez/null-ls.nvim",
		-- event = events.BufReadPost,
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
		-- ft = "go",
		config = function()
			require("plugins_dir.null-ls")
		end,
	})

	-- refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({})
		end,
	})

	-- color schemes
	use({ "folke/tokyonight.nvim", disable = false })
	use({
		"rebelot/kanagawa.nvim",
		config = function()
			require("plugins_dir.colorscheme")
		end,
	})
	use({ "kevinhwang91/rnvimr", commit = "e93671b4ea8" }) -- something broke in latest, i could not do splits

	-- use({ "github/copilot.vim", event = events.OnInsert, opt = true }) -- copilot is bottleneck, for poor startup, and lags telescope
	use({ "github/copilot.vim" }) -- copilot is bottleneck, for poor startup, and lags telescope

	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup()
	-- 		end, 100)
	-- 	end,
	-- })

	use({ "tpope/vim-commentary" })

	use({
		"ellisonleao/glow.nvim",
		ft = "markdown",
		event = "BufRead",
		config = function()
			vim.g.glow_binary_path = vim.fn.stdpath("data") .. "bin"
			vim.g.glow_border = "rounded"
		end,
	})

	use({
		"dcampos/nvim-snippy",
		event = events.InsertEnter,
		config = function()
			require("snippy").setup({})
		end,
	})

	-- info: language: markdown
	use({ "davidgranstrom/nvim-markdown-preview", ft = "markdown", event = events.BufReadPost })

	use({ "tpope/vim-surround", event = events.InsertEnter })
	use({ "chaoren/vim-wordmotion", event = events.InsertEnter })
	use({ "mg979/vim-visual-multi", event = events.BufReadPost })

	use({ "simrat39/symbols-outline.nvim", event = events.BufReadPost, after = "nvim-lspconfig" })

	use({
		"windwp/nvim-autopairs",
		event = events.InsertEnter,
		after = "nvim-cmp",
		config = function()
			require("nvim-autopairs").setup({})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	})

	use({ "caenrique/nvim-toggle-terminal", event = events.BufReadPost })

	-- maximizer toggle
	use({"szw/vim-maximizer"})

	-- AutoCompletion
	use({
		"hrsh7th/nvim-cmp",
		commit="f573479528cac39ff5917a4679529e4435b71ffe",
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
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{
				"hrsh7th/cmp-copilot",
				config = function()
					require("plugins_dir.copilot")
				end,
			},
			-- {
			-- 	"zbirenbaum/copilot-cmp",
			-- 	after = { "copilot.lua", "nvim-cmp" },
			-- },
		},
		-- event = "InsertEnter",
		event = events.BufReadPost,
		config = function()
			require("plugins_dir.nvim-cmp")
		end,
	})

	-- kubernetes
	use({ "andrewstuart/vim-kubernetes", ft = "yaml", event = events.BufReadPost })

	-- auto session with tabby names
	-- use({
	-- 	"jedrzejboczar/possession.nvim",
	-- 	config = function()
	-- 		vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
	-- 		require("possession").setup({})
	-- 	end,
	-- })

	-- auto session
	use({
		"rmagatti/auto-session",
		config = function()
			vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
			require("auto-session").setup({
				log_level = "info",
				-- auto_session_enabled = true,
				auto_session_enabled = true,
				auto_restore_enabled = true,
				auto_session_suppress_dirs = { "~/" },
				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			})
		end,
	})

	-- search and replace
	use({
		"nvim-pack/nvim-spectre",
		event = events.BufReadPost,
		config = function()
			require("spectre").setup()
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("indent_blankline").setup({
				char = "┊",
				filetype_exclude = { "help", "packer" },
				buftype_exclude = { "terminal", "nofile" },
				show_trailing_blankline_indent = true,
			})
		end,
	})

	use({ "sindrets/diffview.nvim", event = events.BufReadPre })
end

local function withAsthetics()
	use({
		"luukvbaal/stabilize.nvim",
		event = events.BufReadPost,
		config = function()
			require("stabilize").setup()
		end,
	})

	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
				},
			})
		end,
	})

	use({
		"folke/todo-comments.nvim",
		event = events.BufReadPre,
		config = function()
			require("plugins_dir.todo-comments")
		end,
	})

	--  align vertically based on search
	use({ "godlygeek/tabular", event = events.BufReadPost })

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	-- tabs with names
	use({
		"nanozuki/tabby.nvim",
		event = events.VimEnter,
		config = function()
			require("tabby").setup({})
		end,
	})

	-- buffers
	use("kazhala/close-buffers.nvim")

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

	use({
		"norcalli/nvim-colorizer.lua",
		event = events.BufReadPre,
		config = function()
			require("colorizer").setup()
		end,
	})

	-- back to where you left
	use({ "farmergreg/vim-lastplace", event = events.VimEnter })

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
			-- { "arkav/lualine-lsp-progress" },
		},
		event = "BufEnter",
		config = function()
			require("plugins_dir.lualine")
		end,
	})

	use({
		"ibhagwan/fzf-lua",
		event = "BufReadPost",
		requires = {
			"kyazdani42/nvim-web-devicons",
			{ "junegunn/fzf", run = "./install --bin" },
		},
		config = function()
			require("plugins_dir.fzf-lua")
		end,
	})

	-- tmux
	use("christoomey/vim-tmux-navigator")
end

local function minimalPackages()
	require("packer").startup({
		function()
			_G.use = use

			use("wbthomason/packer.nvim")
			use({ "dstein64/vim-startuptime", cmd = "StartupTime" })
			use("lewis6991/impatient.nvim") -- for faster neovim

			-- use({
			--   "nathom/filetype.nvim",
			--   config = function()
			--     vim.g.did_load_filetypes = 1
			--   end,
			-- })

			withTelescope()
			withLsp()
			withTS()

			withCodingSetup()
			withAsthetics()
		end,
		config = {
			profile = { enable = true, threshold = 1 },
		},
	})
end

minimalPackages()
