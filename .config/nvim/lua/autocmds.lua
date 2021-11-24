vim.cmd[[
augroup nxtcoder17
    autocmd!
    autocmd BufNewFile jsconfig.json :r $XDG_CONFIG_HOME/nvim/templates/jsconfig.json<CR>
augroup END
]]
