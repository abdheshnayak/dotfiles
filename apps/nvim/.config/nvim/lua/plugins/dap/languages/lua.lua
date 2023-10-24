local dap = require("dap")

local M = {}

M.setup = function()
  dap.configurations.lua = {
    {
      type = "neovim_lua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input("Host [127.0.0.1]: ")
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input({ prompt = "port> ", default = "54321" }))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.adapters.neovim_lua = function(callback, config)
    callback({ type = "server", host = config.host, port = config.port })
  end
end

return M
