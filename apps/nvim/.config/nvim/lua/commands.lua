local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

-- TODO: make this prompt use fzf filters
vim.api.nvim_create_user_command("Todo", function(opts)
  require('fzf-lua').grep({ search = 'TODO|HACK|NOTE|FIXME' })

  -- local query = "TODO|HACK|NOTE|FIXME"
  --
  -- if #opts.fargs > 0 then
  --   query = table.concat(opts.fargs, "|")
  -- end
  --
  -- require("telescope.builtin").grep_string({
  --   search = query,
  --   default_text = query,
  --   sorter = sorters.get_fzy_sorter(),
  -- })
end, {
  nargs = "*",
  complete = function(_arglead, _cmdline, _cursorpos)
    return { "TODO", "HACK", "NOTE", "FIXME" }
  end,
})

-- TODO: hi
-- HACK: hi
vim.api.nvim_create_user_command("X", function(opts)
  vim.print(vim.fn.luaeval(opts.args))
end, { nargs = 1 })
