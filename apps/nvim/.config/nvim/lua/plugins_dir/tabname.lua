local M = {}

local hasTabby = function()
	return packer_plugins["tabby.nvim"] and packer_plugins["tabby.nvim"].loaded
end

M.run = function()
	if hasTabby() then
		local tabs = vim.api.nvim_list_tabpages()
		vim.cmd("tabrewind")
		print(vim.inspect(tabs))
		for tabidx, tabnr in ipairs(tabs) do
			pwd = vim.fn.getcwd()
			name = string.gsub(pwd, "(.*(/))", "")
			-- print(require("tabby.filename").relative(vim.api.nvim_tabpage_get_win(tabnr)))

			-- print(vim.inspect(vim.fn.tabpagewinnr(tabnr)))

			-- lei _ = gettabvar(a:n, 'cwd')

			-- r = vim.fn.gettabvar(tabnr, 'pwd')

			-- print(vim.inspect(r))

			-- print()
			-- require("tabby.util")

			require("tabby.util").set_tab_name(tabidx, name)


			-- require("tabby.filename").getcwd(tabidx)


			-- vim.cmd("TabRename " .. name)

			vim.cmd("tabnext")
		end


		vim.cmd("tabrewind")

	end
end


return M
