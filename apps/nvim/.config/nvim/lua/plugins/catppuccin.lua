require("catppuccin").setup({
  flavour = "latte", -- mocha, macchiato, frappe, latte
  background = {
    -- dark = "mocha",
    light = "latte",
  },
  highlight_overrides = {
    all = function()
      return {
        -- CmpItemAbbrMatch = { fg = "green" },
      }
    end,
  },
  transparent_background = false,
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
