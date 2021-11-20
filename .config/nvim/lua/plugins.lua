vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
  use("wbthomason/packer.nvim")

  -- color schemes
  use({
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim",
  })
  use("shaunsingh/nord.nvim")
  use("sainnhe/everforest")
  use("sainnhe/gruvbox-material")
  use("maaslalani/nordbuddy")
  use("norcalli/nvim-colorizer.lua")

  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("mbbill/undotree")
  use("kevinhwang91/nvim-hlslens")
  use("mg979/vim-visual-multi")

  -- coc lsp
  use {'neoclide/coc.nvim', branch = 'release'}
  use { 'junegunn/fzf', run = './install --bin' }
  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons'
    }
  }

  -- LSP
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-compe")
  use("onsails/lspkind-nvim")
  use("folke/lua-dev.nvim")
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp-status.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("ray-x/lsp_signature.nvim")

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  -- Code Beauty
  use("mhartington/formatter.nvim")

  -- AutoCompletion

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "ray-x/cmp-treesitter" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/vim-vsnip-integ" },
      { "Saecki/crates.nvim" },
      { "f3fora/cmp-spell" },
    },
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("windwp/nvim-autopairs")
  use("p00f/nvim-ts-rainbow")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("andymass/vim-matchup")
  use("nvim-treesitter/nvim-treesitter-refactor")
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
end)

-- Setting up Nord Colorscheme
vim.g.nord_contrast = true
vim.g.nord_borders = true
-- require("nord").set()
vim.cmd([[ colorscheme nordbuddy ]])

require("gitsigns").setup()

require("colorizer").setup()

---------------------------------------\ Lsp signature

cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ", -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false, -- set to true if you want to use lspsaga popup
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  transpancy = 10, -- set this value if you want the floating windows to be transpant (100 fully transpant), nil to disable(default)
  handler_opts = {
    border = "single", -- double, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

  transpancy = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommanded:
-- require("lsp_signature").setup(cfg)

-----------------------------------------------------\ lsp-kind
--require("lspkind").init({
--  with_text = true,

--  symbol_map = {
--    Text = "",
--    Method = "ƒ",
--    Function = "ﬦ",
--    Constructor = "",
--    Variable = "",
--    Class = "",
--    Interface = "ﰮ",
--    Module = "",
--    Property = "",
--    Unit = "",
--    Value = "",
--    Enum = "了",
--    Keyword = "",
--    Snippet = "﬌",
--    Color = "",
--    File = "",
--    Folder = "",
--    EnumMember = "",
--    Constant = "",
--    Struct = "",
--  },
--})

--------------------------------------------------------\ nvim-cmp

---- local cmp = require("cmp")

---- cmp.setup({
----   snippet = {
----     expand = function(args)
----       vim.fn["vsnip#anonymous"](args.body)
----     end,
----   },

----   mapping = {
----     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
----     ["<C-f>"] = cmp.mapping.scroll_docs(4),
----     ["<C-Space>"] = cmp.mapping.complete(),
----     ["<CR>"] = cmp.mapping.confirm({ select = true }),
----     ["<C-e>"] = cmp.mapping.close(),
----     ["<C-p>"] = cmp.mapping.select_prev_item(),
----     ["<C-n>"] = cmp.mapping.select_next_item(),
----   },
----   documentation = {
----     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
----   },
----   sources = {
----     -- 'crates' is lazy loaded
----     { name = "nvim_lsp" },
----     { name = "treesitter" },
----     { name = "vsnip" },
----     { name = "path" },
----     {
----       name = "buffer",
----       opts = {
----         get_bufnrs = function()
----           return vim.api.nvim_list_bufs()
----         end,
----       },
----     },
----     { name = "spell" },
----   },
----   formatting = {
----     format = function(entry, vim_item)
----       vim_item.kind = string.format("%s %s", require("lspkind").presets.default[vim_item.kind], vim_item.kind)
----       vim_item.menu = ({
----         nvim_lsp = "ﲳ",
----         nvim_lua = "",
----         treesitter = "",
----         path = "ﱮ",
----         buffer = "﬘",
----         zsh = "",
----         vsnip = "",
----         spell = "暈",
----       })[entry.source.name]

----       return vim_item
----     end,
----   },
---- })

-------------------------------------------------------------\ nvim autopairs
---- require("nvim-autopairs.completion.cmp").setup({
----   map_cr = false, --  map <CR> on insert mode
----   map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
----   auto_select = true, -- automatically select the first item
----   insert = false, -- use insert confirm behavior instead of replace
----   map_char = { -- modifies the function or method delimiter by filetypes
----     all = "(",
----     tex = "{",
----   },
---- })

---------------------------------------------------------------\ Formatter
--require("formatter").setup({
--  logging = false,
--  filetype = {
--    javascript = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    json = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    typescript = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    html = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    css = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    scss = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    markdown = {
--      function()
--        return {
--          exe = "prettier",
--          stdin = false,
--        }
--      end,
--    },
--    lua = {
--      -- Stylua
--      function()
--        return {
--          exe = "stylua",
--          args = { "--indent-width", 2, "--indent-type", "Spaces" },
--          stdin = false,
--        }
--      end,
--    },
--  },
--})

---- AutoFormat on Save
--vim.api.nvim_exec(
--  [[
--augroup AutoFormatter
--  autocmd!
--  autocmd BufWritePost *.js,*.jsx,*.json,*.css,*.lua,*.md,*.html :FormatWrite
--augroup END
--]],
--  true
--)

-- Telescope

local actions = require("telescope.actions")

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    prompt_prefix = "λ -> ",
    selection_caret = "|> ",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
  buffers = {
    sort_lastused = true,
    theme = "ivy",
    previewer = true,
    mappings = {
      i = {
        ["<c-d>"] = actions.delete_buffer,
      },
      n = {
        ["<c-d>"] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
  },
})

-- Extensions

-- require('telescope').load_extension('octo')
local Telescope = {}
require("telescope").load_extension("fzf")
function Telescope.nvim_config()
  require("telescope.builtin").file_browser({
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function Telescope.file_explorer()
  require("telescope.builtin").file_browser({
    prompt_title = " File Browser",
    path_display = { "shorten" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
  matchup = { enable = true },
  autotag = {
    enable = true,
  },
  autopairs = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },

  -- Rainbow Delimiters
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, like HTML, jsx elements
    max_file_lines = 1000,
    colors = {
      "#7f9626",
      "#76be9f",
      "#9bcfde",
      "#599f8c",
      "#8b9dc3",
    }, -- table of hex strings
    -- termcolors = { }, -- table of colour name strings
  },

  -- Context CommentString
  context_commentstring = {
    enable = true,
  },

  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
    highlight_definitions = { enable = true },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gnd",
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- @TODOUA: figure out if I need the 2 below
        goto_next_usage = "<a-*>", -- is this redundant?
        goto_previous_usage = "<a-#>", -- also this one?
      },
    },
    -- highlight_current_scope = {enable = true}
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    -- @TODOUA: these selectors may or may not helpful workflow
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

------------------------\ Highlight Search
require("hlslens").setup({
  calm_down = true,
  nearest_only = true,
  nearest_float_when = "always",
})
