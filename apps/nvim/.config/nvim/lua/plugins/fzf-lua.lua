local actions = require("fzf-lua.actions")

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
  "telescope",
  fzf_opts = {
    ["--layout"] = "reverse",
  },
  global_resume = true,
  global_resume_query = true,
  global_resume_prompt = "resume: ",

  -- global_files_prompt = "Files❯ ",

  winopts = {
    preview = {
      -- layout = "vertical",
      horizontal = "right:40%",
    },
    height = 0.5, -- window height
    width = 1,  -- window width
    row = 1,    -- window row position (0=top, 1=bottom)
    col = 0.50, -- window col position (0=left, 1=right)
  },

  -- files = {
  --   -- providers = { "git_files" },
  --   prompt = "Files❯ ",
  --   cmd = "",         -- "fd --type f",
  --   git_icons = true, -- show git icons?
  --   file_icons = true, -- show file icons?
  --   color_icons = true, -- colorize file|git icons
  --   -- reverse = true,            -- reverse list?
  --   actions = {
  --     ["default"] = actions.file_edit,
  --     ["ctrl-s"] = actions.file_split,
  --     ["ctrl-v"] = actions.file_vsplit,
  --     ["ctrl-t"] = actions.file_tabedit,
  --     ["ctrl-q"] = actions.file_sel_to_qf,
  --     ["ctrl-y"] = function(selected)
  --       print(selected[2])
  --     end,
  --   },
  -- },

  actions = {
    buffers = {
      -- providers that inherit these actions:
      --   buffers, tabs, lines, blines
      ["default"] = actions.buf_edit,
      ["ctrl-s"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit,
      ["ctrl-t"] = actions.buf_tabedit,
      ["ctrl-d"] = { actions.buf_del, actions.resume },
    },
  },
})

local M = {}

M.live_files2 = function()
  local cwd = vim.loop.cwd()
  fzf_lua.fzf_live(function(q)
    -- local execCmd = { "rg", "*", "--threads", "3", "--files", "--iglob", "!.git", "--hidden", "--sort", "path" }
    -- local execCmd = {"rg", "--files"}
    local execCmd = { "fd", ".", "-t", "f", "-t", "l", "-L" }

    print("query:", q)

    local searchQuery = q

    if q:sub(1, 2) == "^p" then
      searchQuery = q:sub(3)
      table.insert(execCmd, vim.g.root_dir)
    else
      table.insert(execCmd, cwd)
    end

    -- local cmd = string.format("%s | fzf -f %s", table.concat(execCmd, " ") .. "", vim.fn.shellescape(searchQuery))
    return table.concat(execCmd, " ") .. ""

    -- local cmd = string.format('%s | fzf -f "%s"', table.concat(execCmd, " "), searchQuery or "")
    -- print(cmd)
    --
    -- return "sh -c " .. cmd
  end, {
    exec_empty_query = true,
    fn_transform = function(x)
      return fzf_lua.make_entry.file(x, {
        file_icons = true,
        color_icons = true,
        strip_cwd_prefix = true,
      })
    end,
  })
end

M.live_files3 = function()
  local cwd = vim.loop.cwd()

  fzf_lua.fzf_live(function(q)
    local rg_args = { "--threads", "3", "--files", "--iglob", "!.git", "--hidden", "--sort", "path", "--" }

    local searchQuery = q

    local prefixed = false

    if q:sub(1, 2) == "^p" then
      searchQuery = q:sub(3)
      prefixed = true
    end

    table.insert(rg_args, searchQuery)

    return function(fzf_cb)
      local Job = require("plenary.job")
      coroutine.wrap(function()
        local co = coroutine.running()
        Job
            :new({
              command = "rg",
              args = rg_args,
              cwd = prefixed and vim.g.root_dir or cwd,
              -- env = { ["a"] = "b" },
              on_exit = function(j, return_val)
                -- print(return_val)
                for _, v in ipairs(j:result()) do
                  fzf_cb(v, function()
                    coroutine.resume(co)
                  end)
                end
              end,
            })
            :sync()
        coroutine.yield()
      end)()
    end
  end)
end

function M.git_history(opts)
  local path = require("fzf-lua.path")
  local core = require("fzf-lua.core")
  local config = require("fzf-lua.config")
  local actions = require("fzf-lua.actions")
  opts = config.normalize_opts(opts, config.globals.git)
  opts.prompt = opts.prompt or "Git History> "
  opts.input_prompt = opts.input_prompt or "Search For> "

  opts.cwd = path.git_root(opts.cwd)
  local cmd = path.git_cwd("git log --pretty --oneline --color", opts.cwd)
  opts.preview = vim.fn.shellescape(
    path.git_cwd("git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}", opts.cwd)
  )

  if not opts.query then
    opts.query = vim.fn.input(opts.input_prompt) or ""
  end

  -- this gets called every keystroke, setup for this
  -- is done inside 'set_fzf_interactive_cmd(opts)'
  opts._reload_command = function(query)
    return ("%s %s"):format(cmd, #query > 0 and "-S " .. vim.fn.shellescape(query) or "")
  end

  -- without this queries won't execute until you start typing
  -- change to false to ignore empty string queries
  opts.exec_empty_query = true
  opts = core.set_fzf_interactive_cmd(opts)

  coroutine.wrap(function()
    local selected = core.fzf(opts)
    if not selected then
      return
    end
    actions.act(opts.actions, selected, opts)
  end)()
end

M.live_files = function()
  local cwd = vim.loop.cwd()
  fzf_lua.fzf_live(function(q)
    local searchQuery = q

    local dir = cwd

    if q:sub(1, 2) == "^p" then
      searchQuery = q:sub(3)
      dir = vim.g.root_dir
    end

    local cmd = string.format('rg --files %s | fzf -f "%s"', dir, searchQuery)
    -- print(cmd)
    return cmd
  end, {
    exec_empty_query = true,
    fn_transform = function(x)
      return fzf_lua.make_entry.file(x, {
        file_icons = true,
        color_icons = true,
        strip_cwd_prefix = true,
      })
    end,
  })
end

return M
