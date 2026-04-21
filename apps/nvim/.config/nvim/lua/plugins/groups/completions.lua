return function(events)
  local copilot = require("plugins.copilot").plugs

  return {
    ["all"] = vim.tbl_extend("force", copilot, {
      {
        "hrsh7th/nvim-cmp",
        event = events.InsertEnter,
        config = function()
          require("plugins.nvim-cmp")
        end,
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("plugins.luasnip")
              require("keymaps-for-plugins").luasnip_keymaps()
            end,
          },
          {
            "dcampos/cmp-emmet-vim",
            event = events.BufRead,
            ft = { "html", "javascriptreact", "typescriptreact" },
            dependencies = {
              "mattn/emmet-vim",
            },
          },
          { "hrsh7th/cmp-nvim-lua", ft = "lua" },
          { "FelipeLema/cmp-async-path" },
          { "onsails/lspkind.nvim" },
          { "saadparwaiz1/cmp_luasnip" },
          { "hrsh7th/cmp-nvim-lsp-signature-help" },
          { "andersevenrud/cmp-tmux" },
          { "hrsh7th/cmp-cmdline" },
          { "hrsh7th/cmp-buffer" },
          { "lukas-reineke/cmp-rg" },
        },
      },
      {
        "jcdickinson/codeium.nvim",
        event = events.BufRead,
        dependencies = {
          "nvim-cmp",
          "MunifTanjim/nui.nvim",
        },
        commit = "bb3ede8de30efe01b976eda8342ae4d40a5ee91f",
        config = function()
          require("codeium").setup({})
        end,
      },
    }),
    ["minimal"] = vim.tbl_extend("force", copilot, {
      {
        "supermaven-inc/supermaven-nvim",
        config = function()
          require("supermaven-nvim").setup({
            keymaps = {
              accept_suggestion = "<M-l>",
            },
          })
        end,
      },
      {
        "hrsh7th/nvim-cmp",
        event = events.InsertEnter,
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          { "lukas-reineke/cmp-rg" },
          { "hrsh7th/cmp-cmdline" },
          { "saadparwaiz1/cmp_luasnip" },
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("plugins.luasnip")
              require("keymaps-for-plugins").luasnip_keymaps()
            end,
          },
          { "onsails/lspkind.nvim" },
        },
        config = function()
          require("plugins.nvim-cmp")
        end,
      },
    }),
  }
end
