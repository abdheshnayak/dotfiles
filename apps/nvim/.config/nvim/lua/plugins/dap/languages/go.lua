local M = {}

local dap = require("dap")
local utils = require("plugins.dap.utils")

--[[
NOTE: dap-configurations `console` support 3 options:
- internalConsole
- integratedTerminal
- externalTerminal
--]]

local function default_go_configurations()
  return {
    {
      name = "Debug a file",
      type = "go",
      request = "launch",
      program = "${file}",
      debugAdapter = "dlv",
      showLog = true,
      console = "integratedConsole",
      -- console = "externalTerminal",
      -- console = "internalTerminal",
      internalTerminal = true,
      externalTerminal = true,
      env = function()
        local x = utils.read_env_file(vim.loop.cwd() .. "/.env")
        local y = utils.read_env_file(vim.loop.cwd() .. "/.secrets/env")
        return vim.tbl_deep_extend("force", y or {}, x or {})
      end,
    },

    {
      type = "go",
      name = "Debug Package",
      request = "launch",
      -- program = "${fileDirname}",
      program = utils.choose_program_dir,
      envFile = function()
        local d = ""
        vim.ui.input({ prompt = "EnvFile: ", default = vim.fn.expand("%:p:h") }, function(input)
          d = input
        end)
        return {
          d,
        }
      end,
    },

    {
      type = "go",
      name = "Debug Package with Args",
      request = "remote",
      program = function()
        return utils.choose_dir("program dir", vim.fn.expand("%:p:h"), nil)
      end,
      env = function()
        local d = ""
        vim.ui.input({ prompt = "env dir > ", default = vim.fn.expand("%:p:h") }, function(input)
          d = input
        end)
        local x = utils.read_env_file(d .. "/.env")
        local y = utils.read_env_file(d .. "/.secrets/env")
        local z = vim.tbl_deep_extend("force", y, x or {})
        print(vim.inspect(z))
        return z
      end,
      args = utils.get_arguments,
      console = "externalTerminal",
    },

    {
      type = "go",
      name = "Test Package",
      request = "launch",
      mode = "test",
      program = utils.choose_program_dir,
      env = {
        project_root = function()
          utils.choose_dir("env:project_root = ", vim.g.root_dir)
        end,
      },
    },
  }
end

local function default_go_adapters()
  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "bash",
      args = {
        "-c",
        "dlv dap -l 127.0.0.1:${port} --api-version 2 --check-go-version false --allow-non-terminal-interactive 2>&1 | tee /tmp/debug.stdout",
        -- "dlv debug --accept-multiclient --headless -l 127.0.0.1:${port} --api-version 2 --allow-non-terminal-interactive 2>&1 | tee /tmp/debug.stdout",
        -- "dlv debug --continue --accept-multiclient --headless -l 127.0.0.1:${port} --api-version 2 --allow-non-terminal-interactive 2>&1 | tee /tmp/debug.stdout",
      },
    },
    options = {
      initialize_timeout_sec = 20,
    },
    enrich_config = utils.adapter_inject_env,
  }

  dap.adapters.go_test = {
    type = "server",
    port = "${port}",
    executable = {
      command = "bash",
      args = {
        "-c",
        "dlv test --api-version 2 --allow-non-terminal-interactive 2>&1 | tee /tmp/debug.stdout",
      },
    },
    options = {
      initialize_timeout_sec = 20,
    },
    enrich_config = utils.adapter_inject_env,
  }
end

-- [source](nvim-dap-go)
M.setup = function()
  dap.set_log_level("TRACE")
  dap.defaults.fallback.focus_terminal = true
  dap.defaults.fallback.force_external_terminal = true
  dap.defaults.fallback.external_terminal = {
    command = "/usr/bin/alacritty",
    args = { "-e" },
  }

  dap.configurations.go = {}

  local projectDapFile = vim.g.root_dir .. "/.tools/nvim/dap/go.lua"
  if utils.file_exists(projectDapFile) then
    vim.cmd("so " .. projectDapFile)
  end

  local goConfigs = default_go_configurations()
  for _, cfg in ipairs(goConfigs) do
    table.insert(dap.configurations.go, cfg)
  end
  default_go_adapters()
end

return M
