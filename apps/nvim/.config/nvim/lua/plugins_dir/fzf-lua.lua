local actions = require "fzf-lua.actions"

require("fzf-lua").setup({
  global_resume = true,
  global_resume_query = true,
  global_resume_prompt = "resume: ",

  winopts = {
    preview = {
      horizontal = "right:40%",
    },
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

