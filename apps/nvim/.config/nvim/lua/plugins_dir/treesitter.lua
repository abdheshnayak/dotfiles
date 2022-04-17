require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "ocamllex" },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-k>",
			node_incremental = "<c-k>",
			-- scope_incremental = "<c-w>",
			node_decremental = "<C-j>",
		},
	},
	indent = { enable = false },
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	-- nvim autopairs
	autopairs = { enable = true },

	-- Rainbow Delimiters
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, like HTML, jsx elements
		max_file_lines = 1000,
		colors = {
			"#D3ECA7",
			"#a5a58d",
			"#4FD3C4",
			"#7C99AC",
		}, -- table of hex strings
	},

	-- Context CommentString
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},

	-- refactor = {
	--   smart_rename = {
	--     enable = true,
	--     keymaps = { smart_rename = "grr" },
	--   },
	--   highlight_definitions = { enable = true },
	--   -- navigation = {
	--   --   enable = true,
	--   --   keymaps = {
	--   --     goto_definition_lsp_fallback = "gnd",
	--   --     -- list_definitions = "gnD",
	--   --     -- list_definitions_toc = "gO",
	--   --     -- @TODOUA: figure out if I need the 2 below
	--   --     goto_next_usage = "<a-*>", -- is this redundant?
	--   --     goto_previous_usage = "<a-#>", -- also this one?
	--   --   },
	--   -- },
	--   -- highlight_current_scope = {enable = true}
	-- },

	textobjects = {
		-- lsp_interop = {
		--   enable = true,
		--   border = "none",
		--   peek_definition_code = {
		--     ["<leader>df"] = "@function.outer",
		--     ["<leader>dF"] = "@class.outer",
		--   },
		-- },

		--   move = {
		--     enable = true,
		--     set_jumps = true, -- whether to set jumps in the jumplist
		--     goto_next_start = {
		--       ["]m"] = "@function.outer",
		--       ["]]"] = "@class.outer",
		--     },
		--     goto_next_end = {
		--       ["]M"] = "@function.outer",
		--       ["]["] = "@class.outer",
		--     },
		--     goto_previous_start = {
		--       ["[m"] = "@function.outer",
		--       ["[["] = "@class.outer",
		--     },
		--     goto_previous_end = {
		--       ["[M"] = "@function.outer",
		--       ["[]"] = "@class.outer",
		--     },
		--   },

		-- @TODO: these selectors may or may not helpful workflow
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["ac"] = "@call.outer",
				["ic"] = "@call.inner",
			},
		},
	},
})
