augroup filetypedetect
" autocmd BufNewFile,BufRead *.yml.tpl, if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif
autocmd BufNewFile,BufRead *.yml.tpl setlocal filetype=gotmpl
augroup END
