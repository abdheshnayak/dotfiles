vim.g.root_dir = vim.fn.getcwd()
table.concat(vim.opt.path, vim.g.root_dir)

require('disable-builtins')
require("impatient")
-- require("packer_compiled")
require("options")
require("plugins")
require("keymaps")
require("plugins_dir")
require("autocmds")

local dirExtension = vim.fn.getcwd() .. "/.nxtcoder17.lua"
if vim.fn.filereadable(dirExtension) > 0 then
    vim.cmd("luafile" .. dirExtension)
end

if vim.g.nvui then
    -- vim.opt.linespace = 4
    vim.cmd [[ 
        NvuiScrollAnimationDuration 0.2
        NvuiCursorAnimationDuration 0.1
    ]] 
end

vim.cmd [[
    let &t_Cs = "\e[6m"
    let &t_Ce = "\e[24m"
    hi SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl
]]

-- neovide
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_length=0.5
vim.g.neovide_input_use_logo = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"

