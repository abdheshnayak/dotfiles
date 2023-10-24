-- vim.keymap.set({ "n", "v" }, "<C-w>", "<Nop>", {})
-- vim.keymap.set({ "n", "v" }, "<C-S-w>", "<Nop>", {})

require("nvim-treesitter.configs").setup({
  -- ensure_installed = "all",
  ensure_installed = {
    "go",
    "javascript",
    "typescript",
    "yaml",
    "json",
    "jsonc",
    "json5",
    "markdown",
    "markdown_inline",
    "lua",
    "graphql",
    "html",
    "css",
    "python",
    "bash",
  },
  -- ignore_install = { "ocamllex", "swift", "phpdoc" },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-e>",
      node_incremental = "<C-e>",
      -- scope_incremental = false,
      node_decremental = "<C-W>",

      -- init_selection = "<M-w>",
      -- node_incremental = "<M-w>",
      -- -- scope_incremental = false,
      -- node_decremental = "<M-W>",
    },
  },
  indent = { enable = true },
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
    config = {
      gotmpl = "{{/* %s */}}",
    },
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
    lsp_interop = {
      enable = true,
      -- border = "none",
      border = "single",
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["sK"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },

    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    --   goto_next_start = {
    --     ["<C-j>"] = { query = "@function.outer", desc = "Next Function Start" },
    --     ["<M-j>"] = { query = "@block.outer", desc = "Next Block Start" },
    --     -- ["<M-j>"] = { query = "@statement.outer", desc = "Next Statement Start" },
    --     -- ["]m"] = "@function.outer",
    --     -- ["]]"] = "@class.outer",
    --   },
    --   goto_next_end = {
    --     ["<C-S-j>"] = "@function.outer",
    --     -- ["]M"] = "@function.outer",
    --     -- ["]["] = "@class.outer",
    --   },
    --   goto_previous_start = {
    --     ["<C-k>"] = "@function.outer",
    --     ["<M-k>"] = { query = "@block.outer", desc = "Previous Block Start" },
    --     -- ["<M-k>"] = { query = "@statement.outer", desc = "Previous Statement Start" },
    --     -- ["[m"] = "@function.outer",
    --     -- ["[["] = "@class.outer",
    --   },
    --   goto_previous_end = {
    --     ["<C-S-k>"] = "@function.outer",
    --     -- ["[M"] = "@function.outer",
    --     -- ["[]"] = "@class.outer",
    --   },
    -- },

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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    -- url = "https://github.com/ngalaiko/tree-sitter-go-template",
    url = "https://github.com/msvechla/tree-sitter-go-template",
    branch = "fix_brackets",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
}
