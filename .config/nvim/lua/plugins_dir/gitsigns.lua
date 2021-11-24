require("gitsigns").setup({
  signs = {
    add = { hl = "DiffAdd", text = " ", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "柳", numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = " ", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = " ", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChange", text = " ", numhl = "GitSignsChangeNr" },
  },
  keymaps = {},
  watch_index = {
    interval = 100,
  },
  -- current_line_blame = true,
  sign_priority = 1,
  update_debounce = 100,
  status_formatter = nil,
  use_decoration_api = true,
  use_internal_diff = true,
})
