function tokyoNight()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_italic_variables = true
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

    vim.g.tokyonight_colors = {
      comment = "#61768c",
    }
    vim.cmd[[ colorscheme tokyonight ]]
end

function kanagawa()
  local defaultColors = require("kanagawa.colors").setup()

  local colors = {
    -- nxtSelection1 = "#355078"
    nxtSelection1 = "#273e5e"
  }

  local overrides = {
    Visual = {
      bg = colors.nxtSelection1,
    },
    TSException = {
      fg = defaultColors.oniViolet,
    },
    TSKeywordReturn = {
      fg = defaultColors.lightBlue,
    },
    javascriptTSVariableBuiltin = {
      fg = defaultColors.lightBlue,
    },
  }

  require'kanagawa'.setup({ overrides = overrides, colors = colors })
  vim.cmd('colorscheme kanagawa')
end

kanagawa()
-- tokyoNight()
