local cmp = require("cmp")

local icons = {
  Text = "   ",
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
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
  sources = {
    -- 'crates' is lazy loaded
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "ultisnips" },
    { name = "path" },
    {
      name = "buffer",
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "spell" },
    { name = "tmux" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s (%s)', icons[vim_item.kind], vim_item.kind) 
      vim_item.menu = "";

      return vim_item
    end,
  },
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
