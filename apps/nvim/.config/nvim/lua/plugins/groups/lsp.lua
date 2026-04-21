return function(events)
  return {
    {
      "windwp/nvim-ts-autotag",
      event = events.InsertEnter,
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "gopls",
          "bash-language-server",
          "eslint_d",
          "lua-language-server",
          "tailwindcss-language-server",
          "typescript-language-server",
          "stylua",
          "gofumpt",
          "goimports_reviser",
          "golines",
        },
      },
      config = function()
        require("mason").setup()
      end,
      dependencies = {
        {
          "WhoIsSethDaniel/mason-tool-installer.nvim",
          config = function()
            require("plugins.mason-tool-installer")
          end,
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      event = events.BufRead,
      config = function()
        require("plugins.lspconfig")
      end,
      dependencies = {
        { "folke/neodev.nvim", ft = "lua" },
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        {
          "nvimtools/none-ls.nvim",
          config = function()
            require("plugins.null-ls")
          end,
          dependencies = {
            "nvimtools/none-ls-extras.nvim",
          },
        },
      },
    },
    {
      "olexsmir/gopher.nvim",
      ft = "go",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("gopher").setup()
      end,
    },
    {
      "folke/trouble.nvim",
      cmd = {
        "Trouble",
        "TroubleToggle",
        "TroubleRefresh",
      },
      config = function()
        require("trouble").setup({})
      end,
    },
  }
end
