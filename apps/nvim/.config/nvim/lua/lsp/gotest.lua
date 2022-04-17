local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local implement_interface = function(prompt_bufnr)
	actions.close(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	vim.api.nvim_command(":GoImpl " .. entry.value)
end


function my_custom_picker(results)
	pickers.new(opts, {
		prompt_title = 'Select interface to implement',
		finder = finders.new_table(results),
		sorter = sorters.fuzzy_with_index_bias(),
		attach_mappings = function(_, map)
			map('i', '<cr>', implement_interface)
			return true
		end,
	}):find()
end

local M = {}

M.run = function()


	d = vim.lsp.diagnostic.get_all()
	l = {}
	for _, v in ipairs(d) do
		for _, w in ipairs(v) do
			-- print(vim.inspect(w))
			msg = w.message
			match = string.match(msg, 'does not implement')

			if match == nil then
			else
				op = string.gsub(msg, '(.*(does not implement ))', '')
				op = string.gsub(op, '(( .missing method ).*)', '')
				-- l.insert(op)
				table.insert(l, op)
				-- print(op)
			end


			-- print(w.message)
		end
	end
	-- print(l)
	-- print(vim.inspect(d))
	my_custom_picker(l)
end



return M
