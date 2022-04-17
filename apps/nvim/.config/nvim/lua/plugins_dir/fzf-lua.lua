local actions = require "fzf-lua.actions"

require("fzf-lua").setup({
  global_resume = true,
  global_resume_query = true,
  global_resume_prompt = "resume: ",

  winopts = {
    preview = {
      horizontal = "right:40%",
    },
    height           = 0.40, -- window height
    width            = 1,    -- window width
    row              = 1,    -- window row position (0=top, 1=bottom)
    col              = 0.50, -- window col position (0=left, 1=right)
  },

  actions = {
    buffers = {
      -- providers that inherit these actions:
      --   buffers, tabs, lines, blines
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
      ["ctrl-d"]      = {actions.buf_del, actions.resume},
    }
  },
})

