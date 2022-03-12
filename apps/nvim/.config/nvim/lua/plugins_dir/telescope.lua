local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local action_state = require('telescope.actions.state')

-- Custom Find Command
local findCmd
if vim.fn.executable("fd") then
  findCmd = { "fd", "-t", "f", "-H", "-E", ".git", "--strip-cwd-prefix" }
elseif vim.fn.executable("rg") then
  findCmd = { "rg", "--files", "--iglob", "!.git", "--hidden" }
end

-- Don't preview the binaries
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local previewMaker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          -- maybe we want to write something to the buffer here
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end,
    })
    :sync()
end

telescope.setup({
  defaults = {
    previewer = previewMaker,
    cache_picker = {
      num_pickers = -1
    }
  },
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
      find_command = findCmd,
      prompt_title = "  Looking for files",
    },
    lsp_references = {
      theme = "ivy",
      prompt_title = "  Looking for references",
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

telescope.load_extension("fzf")
-- telescope.load_extension("dap")

local M = {}

M.tabs = function()
  return telescope.tabs()
end

M.grep = function()
  telescope_builtin.grep_string({
    prompt_title = " Grep word",
    search = vim.fn.input("   Grep for word> ", vim.fn.expand("<cword>")),
    use_regex = true,
  })
end

M.nvim_config = function()
  require("telescope.builtin").find_files({
    prompt_title = "  Nvim Config",
    cwd = "~/me/jeera-rice",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
    theme='ivy'
  })
end

M.jeera_rice = function()
  M.find_files({
    prompt_title = "  Jeera Rice",
    cwd = "~/me/jeera-rice",
    theme='ivy',
  });
end

M.list_sessions = function()
  require("session-lens").search_session()
end

-- Docker Images
M.dockerImages = function()
  pickers.new({
    theme = "ivy",
    results_title = "Docker Images",
    finder = finders.new_oneshot_job({"docker", "images"}),
    sorter = sorters.get_fuzzy_file(),
    mappings = {
      n = {
        ["<C-d>"] = function(args) print(args) end,
      },
      i = {
        ["<C-d>"] = function(args) print(args) end,
      },
    },
  }):find()
end

local goto_window = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  -- make vim show the given window
  vim.api.nvim_set_current_win(entry.value)
end

M.tabs = function()
  local tabs = vim.api.nvim_list_tabpages()
  local windows = {};
  for tabidx, tabnr in ipairs(tabs) do
    local windownrs = vim.api.nvim_tabpage_list_wins(tabnr)
    for windownr, windowid in ipairs(windownrs) do
      local bufnr = vim.api.nvim_win_get_buf(windowid)
      local bufstr = '[TAB] ' .. tabnr .. ' ' .. string.sub(vim.api.nvim_buf_get_name(bufnr), vim.fn.getcwd():len()+2)
      table.insert(windows, { 
        ordinal = bufstr , display = bufstr, value = windowid 
      })
    end
  end
  pickers.new({
    theme = "ivy",
    results_title = "Tabs",
    finder = finders.new_table({
      results = windows,
      entry_maker = function (x) return x end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(item, map)
      -- use our custom action to go the window id
      map( 'i', '<CR>', goto_window)
      map( 'n', '<CR>', goto_window)
      return true
    end,
  }):find()
end

return M
