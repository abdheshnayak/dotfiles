return function(events)
  return {
    ["all"] = {
      {
        "nvim-treesitter/nvim-treesitter",
        event = events.BufRead,
        config = function()
          require("plugins.treesitter")
        end,
        dependencies = {
          { "nvim-treesitter/nvim-treesitter-refactor" },
          { "nvim-treesitter/nvim-treesitter-textobjects" },
          { "p00f/nvim-ts-rainbow" },
          { "nvim-treesitter/playground" },
        },
      },
      {
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        config = function()
          require("sentiment").setup({})
        end,
      },
      {
        "kevinhwang91/nvim-ufo",
        event = events.BufRead,
        requires = "kevinhwang91/promise-async",
        config = function()
          require("plugins.nvim-ufo")
        end,
      },
      {
        "ziontee113/syntax-tree-surfer",
        dependencies = {
          "nvim-treesitter",
        },
        event = events.BufRead,
        config = function()
          require("plugins.syntax-tree-surfer")
        end,
      },
      { "fladson/vim-kitty", ft = "kitty" },
    },
    ["minimal"] = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = events.BufRead,
        dependencies = { "nvim-treesitter" },
        config = function()
          require("treesitter-context").setup({
            enable = true,
            multiwindow = false,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
          })
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({})
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter",
        event = events.BufRead,
        config = function()
          require("plugins.treesitter")
        end,
        dependencies = {
          { "nvim-treesitter/nvim-treesitter-textobjects" },
          { "nvim-treesitter/playground" },
        },
      },
      {
        "ziontee113/syntax-tree-surfer",
        dependencies = {
          "nvim-treesitter",
        },
        event = events.VeryLazy,
        config = function()
          require("plugins.syntax-tree-surfer")
        end,
      },
      {
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        config = function()
          require("sentiment").setup({})
        end,
      },
    },
  }
end
