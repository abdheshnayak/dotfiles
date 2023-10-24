-- local palette_colors = {
--   -- Bg Shades
--   sumiInk0 = "#16161D",
--   sumiInk1b = "#181820",
--   sumiInk1c = "#1a1a22",
--   sumiInk1 = "#1F1F28",
--   sumiInk2 = "#2A2A37",
--   sumiInk3 = "#363646",
--   sumiInk4 = "#54546D",
--   -- Popup and Floats
--   waveBlue1 = "#223249",
--   waveBlue2 = "#2D4F67",
--   -- Diff and Git
--   winterGreen = "#2B3328",
--   winterYellow = "#49443C",
--   winterRed = "#43242B",
--   winterBlue = "#252535",
--   autumnGreen = "#76946A",
--   autumnRed = "#C34043",
--   autumnYellow = "#DCA561",
--   -- Diag
--   samuraiRed = "#E82424",
--   roninYellow = "#FF9E3B",
--   waveAqua1 = "#6A9589",
--   dragonBlue = "#658594",
--   -- Fg and Comments
--   oldWhite = "#C8C093",
--   fujiWhite = "#DCD7BA",
--   fujiGray = "#727169",
--   springViolet1 = "#938AA9",
--   oniViolet = "#957FB8",
--   crystalBlue = "#7E9CD8",
--   springViolet2 = "#9CABCA",
--   springBlue = "#7FB4CA",
--   lightBlue = "#A3D4D5", -- unused yet
--   waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua
--   -- waveAqua2  = "#68AD99",
--   -- waveAqua4  = "#7AA880",
--   -- waveAqua5  = "#6CAF95",
--   -- waveAqua3  = "#68AD99",
--
--   springGreen = "#98BB6C",
--   boatYellow1 = "#938056",
--   boatYellow2 = "#C0A36E",
--   carpYellow = "#E6C384",
--   sakuraPink = "#D27E99",
--   waveRed = "#E46876",
--   peachRed = "#FF5D62",
--   surimiOrange = "#FFA066",
--   katanaGray = "#717C7C",
-- }

local kanagawa_theme = "wave"
local kanagawa_colors = require("kanagawa.colors").setup({ theme = kanagawa_theme })

local colors = {
  theme = {
    all = {
      ui = {
        bg_gutter = "none",
      },
    },
  },
  palette = {
    nxtSelection1 = "#273e5e",
    MiniIndentscopeSymbol = "red",
    oniViolet = kanagawa_colors.lightBlue,
  },
}

local overrides = function(themeColors)
  local theme = themeColors.theme
  return {
    Visual = {
      bg = colors.palette.nxtSelection1,
    },
    TSException = {
      fg = kanagawa_colors.palette.oniViolet,
    },
    TSKeywordReturn = {
      fg = kanagawa_colors.palette.lightBlue,
    },
    javascriptTSVariableBuiltin = {
      fg = kanagawa_colors.palette.lightBlue,
    },
    DiagnosticError = {
      bg = kanagawa_colors.palette.winterRed,
      fg = kanagawa_colors.palette.peachRed,
    },
    DiagnosticSignError = {
      bg = vim.NIL,
      fg = kanagawa_colors.palette.peachRed,
    },
    ["@keyword.return"] = {
      fg = kanagawa_colors.palette.dragonGreen2,
    },
    ["@method"] = {
      -- fg = themeColors.palette.roninYellow,
      fg = "#dce09b",
      -- bold = true,
      -- italic = true,
    },
    ["@function"] = {
      fg = "#dce09b",
    },
    ["@method.call"] = {
      -- fg = themeColors.palette.roninYellow,
      fg = themeColors.palette.crystalBlue,
    },
    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
    PmenuSbar = { bg = theme.ui.bg_m1 },
    PmenuThumb = { bg = theme.ui.bg_p2 },
  }
end

vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

require("kanagawa").setup({
  compile = true,
  uncercurl = true,
  globalStatus = true,
  transparent = true,
  overrides = overrides,
  colors = colors,
  keywordStyle = { italic = true },
  specialReturn = true, -- special highlight for the return keyword
  theme = kanagawa_theme,
  background = {
    dark = kanagawa_theme,
  },
})
