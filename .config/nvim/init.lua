-- disabling unused neovim builtin plugins

if vim.g.vscode then
    -- require("vscode.main");
else
    require("plugins_dir")
    require('disable-builtins')
    require("options")
    require("plugins")
    require("impatient")
    require("keymaps")
    require("autocmds")
    require("lsp")

    local dirExtension = vim.fn.getcwd() .. "/.abdhesh.lua"
    if vim.fn.filereadable(dirExtension) > 0 then
        vim.cmd("luafile" .. dirExtension)
    end

    -- vim.cmd([[ source $XDG_CONFIG_HOME/nvim/coc.vim ]])
end
