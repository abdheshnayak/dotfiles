local dap = require("dap")
local api = vim.api

dap.listeners.after["event_initialized"]["me"] = function()
  vim.keymap.set("n", "s<leader>", dap.step_over, { silent = true })
  vim.keymap.set("n", "sds", dap.continue, { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
  vim.keymap.set("n", "s<leader>", "<nop>", { silent = true })
  vim.keymap.set("n", "sds", "<nop>", { silent = true })
end

vim.keymap.set("n", "sd", "<nop>")
-- vim.keymap.set("n", "sdk", require("dap.ui.widgets").hover, { silent = true })
vim.keymap.set("n", "sdk", function()
  require("dapui").eval(vim.fn.expand("<cexpr>"), { enter = true })
  -- require("dapui").float_element("watches", { enter = true })
end)

vim.keymap.set("v", "sdk", function()
  require("dapui").float_element("watches", { enter = true })
end, { silent = true })

-- vim.keymap.set("n", "<leader>dk", require("dap.ui.widgets").hover, { silent = true })
vim.keymap.set("n", "sdb", dap.toggle_breakpoint, { silent = true })
-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "sdc", function()
  vim.ui.input({
    prompt = "Breakpoint Condition > ",
    default = "",
  }, function(input)
    dap.set_breakpoint(input)
  end)
end, { silent = true })

vim.keymap.set("n", "sdl", function()
  vim.ui.input({
    prompt = "Logpoint Message > ",
    default = "",
  }, function(input)
    dap.set_breakpoint(nil, nil, input)
  end)
end)

-- dap repl split

-- (without dapui)
vim.keymap.set("n", "sdr", function()
  require("dap").repl.toggle({}, "80vsplit")
  vim.cmd("wincmd l")
end)

-- (with dapui)
-- vim.keymap.set("n", "sdr", function()
--   require("dapui").toggle({ reset = true })
-- end)

vim.keymap.set("n", "sdR", function()
  dap.run_last()
end)
