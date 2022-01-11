-- Tokyo Night theme
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

vim.g.tokyonight_colors = {
  comment = "#61768c",
}

vim.cmd[[ colorscheme tokyonight ]]
