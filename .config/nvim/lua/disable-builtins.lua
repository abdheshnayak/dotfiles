local disabled_built_ins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",

    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",

    "matchit",
    "matchparen",
    "logipat",
    "rrhelper",

    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",

    "spellfile_plugin",
    "shada_plugin",
    "tutor_mode_plugin"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
