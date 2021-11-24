local telescope = require('telescope')
local telescope_builtin = require("telescope.builtin");
local telescope_actions = require("telescope.actions");
local actions = require("telescope.actions")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    lsp_references = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      mappings = {
        n = {
          ["<C-d>"] = actions.delete_buffer,
        },
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
      },
    },
  },
})

require("telescope").load_extension("fzf")


local M = {}

M.find_files = function()
  telescope_builtin.find_files {
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
  }
end

M.grep = function()
  telescope_builtin.grep_string({
    prompt_title = " Grep word",
    search = vim.fn.input("   Grep for word> ", vim.fn.expand("<cword>")),
    use_regex = true,
  })
end



M.nvim_config = function ()
  require("telescope.builtin").file_browser({
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.file_explorer = function ()
  require("telescope.builtin").file_browser({
    prompt_title = " File Browser",
    path_display = { "shorten" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

return M;
