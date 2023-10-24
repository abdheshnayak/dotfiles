require("catppuccin").setup({
  flavour = "mocha", -- mocha, macchiato, frappe, latte
  background = {
    dark = "mocha",
  },
  highlight_overrides = {
    all = function()
      return {
        -- CmpItemAbbrMatch = { fg = "green" },
      }
    end,
  },
  transparent_background = true,
  integrations = {
    fidget = true,
    native_lsp = {
      enabled = true,
      cmp = false,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
  },
})
