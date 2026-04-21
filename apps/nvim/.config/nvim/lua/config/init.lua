local bootstrap = require("config.bootstrap")
local loader = require("config.loader")

local M = {}

function M.setup()
  bootstrap.disable_builtin_plugins()
  bootstrap.disable_unused_providers()

  loader.safe_require("globals")
  loader.safe_require("settings")
  loader.safe_require("autocmds")
  loader.safe_require("keymaps")
  loader.safe_require("plugins-lazy").minimal()
  loader.safe_require("functions")
  loader.safe_require("commands")
  local redraw = loader.safe_require("config.redraw")
  if redraw and redraw.setup then
    redraw.setup()
  end
end

return M
