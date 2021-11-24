-- disabling unused neovim builtin plugins
require'disable-builtins'

-- impatient
require("impatient")

require("keymaps")
require("options")
require("plugins")
require("plugins_dir")
require("lsp")
-- vim.cmd([[ source $XDG_CONFIG_HOME/nvim/coc.vim ]])
--

local dirExtension = vim.fn.getcwd() .. "/.nxtcoder17.lua"
if vim.fn.filereadable(dirExtension) > 0 then
  vim.cmd("luafile" .. dirExtension)
end
