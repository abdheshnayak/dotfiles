local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")

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
    lsp_definitions = {
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
  telescope_builtin.find_files({
    find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
  })
end

M.grep = function()
  telescope_builtin.grep_string({
    prompt_title = " Grep word",
    search = vim.fn.input("   Grep for word> ", vim.fn.expand("<cword>")),
    use_regex = true,
  })
  -- local jobopts = {
    -- entry_maker = function(entry)
    --   local _,_, filename, lnum, col, text = string.find(entry, "([^:]+):(%d+):(%d+):(.*)")

    --   local table = {
    --     ordinal = text,
    --     display = text,
    --   }

    --   return table
    -- end,
  -- }
  -- local rg = {"rg", "--line-number", "--column", "",  vim.fn.getcwd(0)}
  -- return pickers.new({
  --     finder = finders.new_oneshot_job(rg),
  --     sorter = sorters.get_generic_fuzzy_sorter(),
  --   }):find()
end

M.nvim_config = function()
  require("telescope.builtin").file_browser({
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.file_explorer = function()
  require("telescope.builtin").file_browser({
    prompt_title = " File Browser",
    path_display = { "shorten" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.list_sessions = function()
  require("session-lens").search_session()
end


-- WIP: do not use
M.debugger = function(opts)
  local results = {
    "Launch",
    "ToggleBreakpoint",
    "StepOver",
    "StepInto",
    "StepOut",
    "Restart",
    "Reset",
  }
  pickers.new(opts, {
    prompt_title = "vimspector debugger",
    finder = finders.new_table(results),
    sorter = require'telescope.sorters'.get_generic_fuzzy_sorter({}),
    attach_mappings = function(_, map)
      -- Map "<cr>" in insert mode to the function, actions.set_command_line
      map('i', '<cr>', actions.set_command_line)
      return true
    end,
  }):find()
end

return M
