vim.cmd[[
augroup nxtcoder17
    autocmd!
    autocmd BufWrite * mkview
    autocmd BufRead * silent! loadview
augroup END
]]
