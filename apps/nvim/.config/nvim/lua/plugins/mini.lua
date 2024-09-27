require("mini.comment").setup({
  options = {
    custom_commentstring = function()
      return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
    end,
  },
  mappings = {
    comment = "s;",
    comment_line = "s;",
    comment_visual = "s;",
  },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
vim.cmd([[ hi! MiniHipatternsTodo guifg=#2e6b99 guibg=#0d1e2b gui=italic ]])

-- require("mini.indentscope").setup({
--   draw = {
--     delay = 2,
--     animation = require("mini.indentscope").gen_animation.none(),
--   },
-- })
--
-- local miniGrp = vim.api.nvim_create_augroup("MiniGrp", {})
--
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   group = miniGrp,
--   pattern = "*",
--   callback = function()
--     _G.MiniIndentscope.undraw()
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   group = miniGrp,
--   pattern = "*",
--   callback = function()
--     _G.MiniIndentscope.draw()
--   end,
-- })

require("mini.pairs").setup({})

require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    replace = "cs",
    find = "",           -- Find surrounding (to the right)
    find_left = "",      -- Find surrounding (to the left)
    highlight = "",      -- Highlight surrounding
    update_n_lines = "", -- Update `n_lines`
  },
})

require("mini.align").setup({})

local MiniStatusline = require("mini.statusline")

function active_status_line()
  -- stylua: ignore start
  local mode, mode_hl     = MiniStatusline.section_mode({ trunc_width = 120 })
  local git               = MiniStatusline.section_git({ trunc_width = 75 })
  local diagnostics       = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  local filename          = MiniStatusline.section_filename({ trunc_width = 140 })
  local fileinfo          = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  local location          = MiniStatusline.section_location({ trunc_width = 120 })

  local from_project_root = vim.fn.getcwd():sub(#vim.g.root_dir + 2)
  if from_project_root ~= "" then
    from_project_root = "📂 " .. from_project_root
  end

  --local relative_path_to_cwd =

  -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
  -- correct padding with spaces between groups (accounts for 'missing'
  -- sections, etc.)
  return MiniStatusline.combine_groups({
    { hl = mode_hl,                 strings = { mode } },
    { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
    { hl = 'MiniStatuslineFileinfo', strings = { from_project_root } },
    { hl = mode_hl,                  strings = { location } },
  })
  -- stylua: ignore end
end

MiniStatusline.setup({
  set_vim_settings = false,
  content = {
    active = active_status_line,
  },
})
