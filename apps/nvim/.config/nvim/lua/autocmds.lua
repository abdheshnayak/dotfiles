vim.cmd([[
augroup nxtcoder17
    autocmd!
    autocmd BufWrite *.js,*,jsx,*.go,*.py,*.html,*.css mkview
    autocmd BufWrite *.js,*,jsx,*.go,*.py,*.html,*.css silent! loadview
    autocmd BufEnter *.tmpl,*.tmpl.yml,*.tpl set ft=helm
    au BufNewFile,BufRead *.go setlocal noet ts=2 sw=2 sts=2
augroup END
]])

-- Highlight for a few seconds on copying
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500, on_visual = true })
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.laststatus = 3
	end,
})
