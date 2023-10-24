local M = {}

local opts = { silent = true, noremap = true }

M.toggleterm_keymaps = function()
  local terminals = {}

  vim.keymap.set({ "n" }, "st", function()
    local dir = vim.fn.getcwd()
    if terminals[dir] ~= nil then
      terminals[dir]()
      return
    end
    local term = require("toggleterm.terminal").Terminal:new({
      start_in_insert = true,
      dir = vim.fn.getcwd(),
      direction = "float",
    })
    terminals[dir] = function()
      term:toggle()
    end
    term:toggle()
    return
  end, opts)
end

M.rnvimr_keymaps = function()
  vim.keymap.set("n", "<M-o>", ":RnvimrToggle<CR>")
  vim.keymap.set("t", "<M-o>", "<C-\\><C-n>:RnvimrToggle<CR>")
end

M.telescope_keymaps = function()
  vim.keymap.set("n", "sb", require("telescope.builtin").buffers, opts)
  vim.keymap.set("n", "<C-;>", require("plugins.telescope").dapActions)

  -- telescope
  -- vim.keymap.set("n", "sf", ":Telescope find_files<CR>")
  vim.keymap.set("n", "sf", require("plugins.telescope").list_files)
  vim.keymap.set("n", "ff", require("plugins.telescope").grep)
  vim.keymap.set("n", "tl", require("plugins.telescope").only_tabs, { silent = true, noremap = true })
  vim.keymap.set("n", "s/", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true, noremap = true })
end

M.nvim_tmux_navigator_keymaps = function()
  vim.keymap.set("n", "<M-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
  vim.keymap.set("n", "<M-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
  vim.keymap.set("n", "<M-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
  vim.keymap.set("n", "<M-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
end

M.luasnip_keymaps = function()
  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if require("luasnip").choice_active() then
      require("luasnip").change_choice(1)
    end
  end)

  vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if require("luasnip").choice_active() then
      require("luasnip").change_choice(-1)
    end
  end)

  -- vim.keymap.set("n", "<leader>sr", function()
  --   require("spectre").open_visual({ select_word = true })
  -- end)
  --
  -- vim.keymap.set("n", "<leader>r", function()
  --   require("replacer").run()
  -- end)
end

M.spider_keymaps = function()
  -- Keymaps
  vim.keymap.set({ "n", "o", "x" }, "w", function()
    require("spider").motion("w")
  end, { desc = "Spider-w" })
  vim.keymap.set({ "n", "o", "x" }, "e", function()
    require("spider").motion("e")
  end, { desc = "Spider-e" })
  vim.keymap.set({ "n", "o", "x" }, "b", function()
    require("spider").motion("b")
  end, { desc = "Spider-b" })
  vim.keymap.set({ "n", "o", "x" }, "ge", function()
    require("spider").motion("ge")
  end, { desc = "Spider-ge" })
end

M.copilot_mappings = function()
  vim.g.copilot_no_tab_map = true
  vim.keymap.set({ "n", "i" }, "<C-CR>", function()
    -- vim.cmd("call copilot#Accept('<CR/>')")
    require("copilot.suggestion").accept()
  end)
  vim.keymap.set({ "i" }, "<C-j>", function()
    require("copilot.suggestion").next()
  end)
  vim.keymap.set({ "i" }, "<C-k>", function()
    require("copilot.suggestion").prev()
  end)
  vim.keymap.set({ "i" }, "<C-c>", function()
    require("copilot.suggestion").prev()
  end)
end

M.vim_wordmotion_mappings = function()
  vim.cmd([[
    nmap cw ce
    nmap cW cE
  ]])
end

return M
