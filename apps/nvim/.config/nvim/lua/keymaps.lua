------ Nvim Core KeyMappings ------

local opts = { silent = true, noremap = true }

-- resets
vim.keymap.set({ "n", "v" }, ";", ":", opts)
-- vim.keymap.set({ "n", "v" }, "f", "<Nop>")

vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

vim.keymap.set("t", "<esc>", "<C-\\><C-N>", opts)
vim.keymap.set({ "n", "v" }, "cc", '"+y', opts)

--vim.keymap.set({ "n" }, "<leader>f", "<Cmd>Telescope current_buffer_fuzzy_find<CR>")

vim.g.mapleader = ","

-- [ the 's' key ]
vim.keymap.set({ "n", "v" }, "s", "<Nop>", opts)
vim.keymap.set({ "n", "v" }, "ss", ":w<CR>", opts)

-- making splits
vim.keymap.set("n", "si", ":vsplit<CR>", opts)
vim.keymap.set("n", "sm", ":split<CR>", opts)

-- split resize
vim.keymap.set({ "n" }, "<C-M-Left>", "<Cmd>vertical resize -5<CR>", opts)
vim.keymap.set({ "n" }, "<C-M-Right>", "<Cmd>vertical resize +5<CR>", opts)
vim.keymap.set({ "n" }, "<C-M-Up>", "<Cmd>resize -5<CR>", opts)
vim.keymap.set({ "n" }, "<C-M-Down>", "<Cmd>resize +5<CR>", opts)

-- better copy pasting
vim.keymap.set("n", "sp", '"_dP', opts)

-- -- clean other buffers
-- vim.keymap.set("n", "x", function() require("mini.bufremove").wipeout(buf_id, force) end)

-- split navigation
vim.keymap.set("n", "sh", "<C-w>h<CR>", opts)
vim.keymap.set("n", "sl", "<C-w>l<CR>", opts)
vim.keymap.set("n", "sj", "<C-w>j<CR>", opts)
vim.keymap.set("n", "sk", "<C-w>k<CR>", opts)

-- minimize and maximize
vim.keymap.set("n", "mm", "<Cmd>lua require('maximize').toggle()<CR>", opts)

-- buffers closing others
vim.keymap.set("n", "sx", ":BufDelOthers")

-- tabs
vim.cmd("cnoreabbrev tcd silent! windo tcd")
vim.keymap.set("n", "tn", "<cmd>tabnew<CR>|:windo tcd " .. vim.g.root_dir .. "<CR>", opts)
vim.keymap.set("n", "te", "<cmd>tabedit % |:windo tcd " .. vim.g.root_dir .. "<CR>", opts)

-- search centered
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

local function closeFloating()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

--vim.keymap.set("n", "<BS>", ":set nohls <CR>|:lua closeFloating() <CR>", opts)
vim.keymap.set("n", "<BS>", function()
  closeFloating()
  vim.cmd("nohls")
end, opts)
vim.keymap.set("n", "<Esc>", ":nohls<CR>")

-- creating scratch files
vim.api.nvim_create_user_command("Scratch", function()
  vim.cmd("vne | setlocal buftype=nofile | setlocal bufhidden=hide | setlocal noswapfile")
end, {})

vim.api.nvim_create_user_command("LspClearLog", function()
  -- os.getenv("HOME") .. '/.local/state/nvim/lsp.log'
  os.execute(string.format("rm -rf %s/lsp.log", os.getenv("XDG_STATE_HOME") or os.getenv("HOME") .. "/.local/state"))
  -- print(string.format("rm -rf %s/lsp.log", os.getenv("XDG_STATE_HOME") or os.getenv("HOME") .. "/.local/state"))
end, {})

-- because rnvimr shits wqa
vim.keymap.set("c", "wqa", "wa! | qa!", opts)
