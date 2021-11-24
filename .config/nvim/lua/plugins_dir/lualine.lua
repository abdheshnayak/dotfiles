local lualine = require("lualine")

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
}

lualine.setup({
  options = {
    theme = "tokyonight",
    -- section_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    -- component_separators = { left = "░▒▓", right = "▓▒░" },
    component_separators = { left = "", right = "" },
  },

  tabline = {
    lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "tabs" },
  },

  sections = {
    lualine_a = { { "mode", upper = true } },
    lualine_b = {},
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " " },
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.cyan,
      },
      {
        "filename",
        icons_enabled = true,
        file_status = true,
        symbols = { modified = "  ", readonly = " [-]" },
      },
    },
    lualine_x = {
      {
        "diff",
        symbols = { added = " ", modified = " 柳", removed = "  " },
        color_added = colors.green,
        color_modified = colors.orange,
        color_removed = colors.red,
        condition = conditions.hide_in_width,
      },

      { "branch", icon = "" },
    },
    lualine_y = {},
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = { "filetype" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
})
