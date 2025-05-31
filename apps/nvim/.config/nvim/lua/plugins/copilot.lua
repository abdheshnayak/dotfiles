local events = {
  BufEnter = "BufEnter",
  BufRead = "BufRead",
  UIEnter = "UIEnter",
  InsertEnter = "InsertEnter",
  VeryLazy = "VeryLazy",
}

local M = {}

M.plugs = {
  {
    "zbirenbaum/copilot.lua",
    event = events.BufRead,
    config = function()
      require("keymaps-for-plugins").copilot_mappings()
      vim.defer_fn(function()
        require("copilot").setup({
          panel = { enabled = false },
          filetypes = {
            ["*"] = true,
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              -- next = "<M-]>",
              -- prev = "<M-[>",
              -- dismiss = "<C-]>",
              next = "<C-j>",
              prev = "<C-k>",
              dismiss = "<C-c>",
            },
          },
        })
      end, 100)
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  {

    "github/copilot.vim",
    event = events.BufRead,
    config = function()
      require("keymaps-for-plugins").copilot_mappings()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = events.BufRead,
    config = function()
      require("keymaps-for-plugins").copilot_mappings()
      vim.defer_fn(function()
        require("copilot").setup({
          panel = { enabled = false },
          filetypes = {
            ["*"] = true,
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = nil,
          },
        })
      end, 100)
    end,
  },
}

-- M.plugs = {
--   "supermaven-inc/supermaven-nvim",
--   config = function()
--     require("supermaven-nvim").setup({})
--   end,
-- }
M.plugs = {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<M-l>",
          -- clear_suggestion = "<C-]>",
          -- accept_word = "<C-j>",
        },
      })
    end,
  },
}

return M
