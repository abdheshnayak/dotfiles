local cmp = require("cmp")

local icons = {
  Text = "📝",
  Method = "  ",
  Field = " λ ",
  Function = " ⨍ ",
  Constructor = "   ",
  Variable = "[]",
  Class = "  ",
  Interface = "ﰮ ",
  Module = "  ",
  Property = " 襁 ",
  Unit = "   ",
  Value = "  ",
  Enum = " 練",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "∁",
  Struct = "▓",
  Event = "",
  Operator = " ",
  TypeParameter = "  ",
}

cmp.setup({
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },

  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count=10 },
    { name = "snippy", max_item_count=10 },
    -- { name = "treesitter" },
    { name = "path", max_item_count=10 },
    { name = "copilot" },
    { name = "tmux", max_item_count=10 },
  }, 
  {
    {
      name = "buffer",
      max_item_count=5,
      options = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s (%s)', icons[vim_item.kind], vim_item.kind) 
      vim_item.menu = "";

      return vim_item
    end,
  },
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
