local theme = vim.env.THEME

-- Function to determine the flavour and background based on the environment variable
local function get_flavour_and_background_from_env()
  if theme == "dark" then
    return "mocha", {
      dark = "mocha",
    }
  elseif theme == "light" then
    return "latte", {
      light = "latte"
    }
  else
    return "macchiato", "macchiato"  -- Fallback
  end
end

-- Get the flavour and background based on the environment variable
local flavour, background = get_flavour_and_background_from_env()

require("catppuccin").setup({
  -- flavour = "latte", -- mocha, macchiato, frappe, latte
  flavour = flavour,
  background = background,
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
