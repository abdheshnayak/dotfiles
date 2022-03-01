vim.cmd[[
augroup nxtcoder17
    autocmd!
    autocmd BufWrite * mkview
    autocmd BufRead * silent! loadview
    autocmd BufEnter *.tpl set ft=helm
    au BufNewFile,BufRead *.go setlocal noet ts=2 sw=2 sts=2
augroup END
]]
