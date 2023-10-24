local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")

local strings = require("functions.strings")

local log = require("plenary.log").new({ plugin = "telescope", level = "debug" })

local function findCmd()
  if vim.fn.executable("fd") then
    return { "fd", "-t", "f", "-H", "-E", ".git", "--strip-cwd-prefix" }
  end
  if vim.fn.executable("rg") then
    return { "rg", "--files", "--iglob", "!.git", "--hidden" }
  end
end

local ivyCustomLayoutConfig = {
  bottom_pane = {
    height = 17,
  },
}

telescope.setup({
  defaults = {
    -- copied from nvchad/nvim
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      bottom_pane = {
        preview_width = 0.40,
        -- preview_cutoff = 70,
      },
      width = 0.87,
      height = 0.80,
      -- preview_cutoff = 120,
      -- preview_cutoff = 40,
    },
    file_ignore_patterns = { "node_modules" },
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      themes.get_ivy({
        layout_config = ivyCustomLayoutConfig,
      }),
    },
    ["goimpl"] = {
      themes.get_ivy({
        layout_config = ivyCustomLayoutConfig,
      }),
    },
    possession = {
      themes.get_ivy({
        layout_config = ivyCustomLayoutConfig,
      }),
    },
    -- lsp_handlers = {
    --     code_action = {
    --         telescope = require("telescope.themes").get_cursor({}),
    --     },
    -- },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      find_command = findCmd,
      prompt_title = "  Looking for files",
      results_title = "",
    },
    lsp_references = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      prompt_title = "  Looking for references",
      results_title = "",
    },
    lsp_definitions = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      results_title = "",
    },
    grep_string = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      results_title = "",
    },
    current_buffer_fuzzy_find = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      results_title = "",
    },
    buffers = {
      theme = "ivy",
      layout_config = ivyCustomLayoutConfig,
      results_title = "",
      mappings = {
        n = {
          ["<C-d>"] = actions.delete_buffer,
        },
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
      },
    },
    quickfix = {
      theme = "dropdown",
      -- theme = "ivy",
      -- layout_strategy = "bottom_pane",
      layout_config = {
        width = function(_, max_width, _)
          return max_width - 10
        end,
        height = function(_, _, max_lines)
          return 27
          -- return max_lines - 15
        end,
      },
    },
  },
})

local M = {}
M.grep = function()
  telescope_builtin.grep_string({
    results_title = "",
    prompt_title = " Grep word",
    search = vim.fn.input({ prompt = "   Grep for word > ", default = vim.fn.expand("<cword>") }),
    -- search = vim.fn.input("   Grep for word> ", vim.fn.expand("<cword>")),
    use_regex = true,
  })
end

local hasTabby = function()
  return packer_plugins["tabby.nvim"] and packer_plugins["tabby.nvim"].loaded
end

local goto_window = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  -- make vim show the given window
  vim.api.nvim_set_current_win(entry.value)
end

M.only_tabs = function()
  local tabs = vim.api.nvim_list_tabpages()
  local results = {}
  for tabidx, tabnr in ipairs(tabs) do
    table.insert(results, { tabidx, tabnr })
  end

  pickers
      .new(
        themes.get_ivy({
          layout_config = ivyCustomLayoutConfig,
        }),
        {
          results_title = false,
          prompt_title = "Fuzzy Search your tabs, here",
          finder = finders.new_table({
            results = results,
            entry_maker = function(item)
              local tabidx, tabnr = item[1], item[2]

              local value = { tabidx, vim.api.nvim_tabpage_get_win(tabnr) }
              return {
                ordinal = tabidx .. require("tabby.util").get_tab_name(tabnr),
                display = tabidx .. " [TAB] " .. require("tabby.util").get_tab_name(tabnr),
                -- value = " [TAB] " .. require("tabby.util").get_tab_name(tabnr),
                value = value,
              }
            end,
          }),
          sorter = sorters.get_fzy_sorter(),
          -- sorter = sorters.get_generic_fuzzy_sorter(),
          attach_mappings = function(item, map)
            -- use our custom action to go the window id
            map({ "i", "n" }, "<CR>", function(prompt_bufnr)
              actions.close(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              vim.api.nvim_set_current_win(entry.value[2])
            end)

            map({ "n", "i" }, "<C-d>", function(prompt_bufnr)
              actions.close(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              vim.cmd("tabclose " .. entry.value[1])
            end)
            return true
          end,
        }
      )
      :find()
end

M.tabs = function()
  local windows = {}

  -- local bufs = vim.api.nvim_list_bufs()
  -- for _, bufnr in ipairs(bufs) do
  -- 	local bufName = vim.api.nvim_buf_get_name(bufnr)
  -- 	local bufLabel = trim(string.sub(vim.api.nvim_buf_get_name(bufnr), vim.fn.getcwd():len() + 2))
  --
  -- 	if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_get_current_buf() ~= bufnr and bufName ~= "" then
  -- 		table.insert(windows, {
  -- 			ordinal = bufLabel,
  -- 			display = bufLabel,
  -- 			value = bufnr,
  -- 		})
  -- 	end
  -- end

  local tabs = vim.api.nvim_list_tabpages()
  for tabidx, tabnr in ipairs(tabs) do
    local tabLabel = tabidx .. "[TAB]"
    if hasTabby() then
      tabLabel = tabidx .. " [TAB] ( " .. require("tabby.util").get_tab_name(tabnr) .. " )"
    end

    local windownrs = vim.api.nvim_tabpage_list_wins(tabnr)
    for windownr, windowid in ipairs(windownrs) do
      local bufnr = vim.api.nvim_win_get_buf(windowid)
      local bufLabel = strings.trim(string.sub(vim.api.nvim_buf_get_name(bufnr), vim.fn.getcwd():len() + 2))

      if vim.fn.buflisted(bufnr) > 0 then
        local bufstr = tabLabel .. " " .. bufLabel

        table.insert(windows, {
          ordinal = bufstr,
          display = bufstr,
          value = windowid,
        })
      end
    end
  end

  pickers
      .new(
        themes.get_ivy({
          layout_config = {
            bottom_pane = {
              height = 15,
            },
            -- results_height = 10,
          },
        }),
        {
          results_title = "",
          prompt_title = "Fuzzy Search your tabs, here",
          finder = finders.new_table({
            results = windows,
            entry_maker = function(x)
              return x
            end,
          }),
          sorter = sorters.get_fzy_sorter({}),
          attach_mappings = function(item, map)
            -- use our custom action to go the window id
            map("i", "<CR>", goto_window)
            map("n", "<CR>", goto_window)
            return true
          end,
        }
      )
      :find()
end

M.dapActions = function()
  local dap, dapui = require("dap"), require("dapui")
  local items = {
    { key = "start",             value = dap.continue,         desc = "start dap server" },
    { key = "continue",          value = dap.continue },
    { key = "end",               value = dap.close },
    { key = "toggle breakpoint", value = dap.toggle_breakpoint },
    {
      key = "conditional breakpoint",
      value = function()
        dap.set_breakpoint(vim.fn.input("[Breakpoint Condition] > "))
      end,
    },
    { key = "run to cursor", value = dap.run_to_cursor },
    { key = "close dap ui",  value = dapui.close },
    { key = "step over",     value = dap.step_over },
    { key = "step into",     value = dap.step_into },
    { key = "step out",      value = dap.step_out },
  }

  local m = {}
  for _, item in ipairs(items) do
    table.insert(m, {
      ordinal = item.key,
      display = item.key,
      value = item.value,
    })
  end

  pickers
      .new(themes.get_ivy(), {
        results_title = "DAP Actions",
        prompt_title = "Hub for dap actions",
        finder = finders.new_table({
          results = m,
          entry_maker = function(x)
            return x
          end,
        }),
        sorter = sorters.get_fzy_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          return actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            selection.value()
          end)
        end,
      })
      :find()
end

M.list_files = function(query, dir, opts)
  local cwd = dir or vim.loop.cwd()
  local search_query = query or ""
  local opts = opts or { disable_devicons = false }

  local finder = finders.new_job(function(prompt)
    search_query = prompt
    return { "rg", "--threads", "3", "--files", "--iglob", "!.git", "--hidden", "--sort", "path" }
  end, function(item)
    return {
      ordinal = item,
      display = function(entry)
        local hl_group
        local display = utils.transform_path({}, entry.value)
        if entry.value:find(cwd) then
          display = entry.value:sub(#cwd + 2)
        end

        -- source (start): telescope.nvim/lua/telescope/make_entry.lua
        display, hl_group, icon = utils.transform_devicons(entry.value, display, opts.disable_devicons)

        if hl_group then
          return display, { { { 0, #icon }, hl_group } }
        else
          return display
        end
        -- source (end): telescope.nvim/lua/telescope/make_entry.lua
      end,

      value = cwd .. "/" .. item,
    }
  end, nil, cwd)

  local conf = require("telescope.config").values
  pickers
      .new(themes.get_ivy({ layout_config = ivyCustomLayoutConfig }), {
        prompt_title = "Search for Files (<Ctrl-p> to search from project root)",
        default_text = search_query,
        results_title = "",
        cwd = cwd,
        finder = finder,
        previewer = conf.grep_previewer({}),
        sorter = conf.file_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<c-space>", actions.to_fuzzy_refine)
          map("i", "<C-p>", function()
            actions.close(prompt_bufnr)

            if dir == vim.g.root_dir then
              M.list_files(search_query)
            else
              M.list_files(search_query, vim.g.root_dir)
            end
          end)
          return true
        end,
      })
      :find()
end

M.find_in_files = function(query, dir, opts)
  local cwd = dir or vim.loop.cwd()
  local search_query = query or ""
  local opts = opts or { disable_devicons = false }

  local finder = finders.new_job(function(prompt)
    search_query = prompt
    return { "rg", "--threads", "3", "--iglob", "!.git", "--hidden", "--sort", "path" }
  end, function(item)
    return {
      ordinal = item,
      display = function(entry)
        local hl_group
        local display = utils.transform_path({}, entry.value)
        if entry.value:find(vim.g.root_dir) then
          display = entry.value:sub(#vim.g.root_dir + 2)
        end

        -- source (start): telescope.nvim/lua/telescope/make_entry.lua
        display, hl_group, icon = utils.transform_devicons(entry.value, display, opts.disable_devicons)

        if hl_group then
          return display, { { { 0, #icon }, hl_group } }
        else
          return display
        end
        -- source (end): telescope.nvim/lua/telescope/make_entry.lua
      end,

      value = cwd .. "/" .. item,
    }
  end, nil, cwd)

  local conf = require("telescope.config").values
  pickers
      .new(themes.get_ivy({ layout_config = ivyCustomLayoutConfig }), {
        prompt_title = "Search for Files (<Ctrl-p> to search from project root)",
        default_text = search_query,
        results_title = "",
        cwd = cwd,
        finder = finder,
        previewer = conf.grep_previewer({}),
        sorter = conf.file_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<c-space>", actions.to_fuzzy_refine)
          map("i", "<C-p>", function()
            actions.close(prompt_bufnr)

            if dir == vim.g.root_dir then
              M.list_files(search_query)
            else
              M.list_files(search_query, vim.g.root_dir)
            end
          end)
          return true
        end,
      })
      :find()
end

return M
