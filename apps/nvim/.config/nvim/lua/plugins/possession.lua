require("possession").setup({
  session_dir = vim.fn.stdpath("data") .. "/possession",
  silent = true,
  load_silent = true,
  hooks = {
    before_save = function(name)
      return {}
    end,
    after_save = function(name, user_data, aborted)
    end,
    before_load = function(name, user_data)
      return user_data
    end,
    after_load = function(name, user_data)
    end,
  },
  autosave = {
    current = true, -- or fun(name): boolean
    tmp = false, -- or fun(): boolean
    tmp_name = "tmp",
    on_load = true,
    on_quit = true,
  },
  plugins = {
    delete_hidden_buffers = {
      hooks = {
        "before_load",
        vim.o.sessionoptions:match("buffer") and "before_save",
      },
      force = true, -- or fun(buf): boolean
    },
  },
})

