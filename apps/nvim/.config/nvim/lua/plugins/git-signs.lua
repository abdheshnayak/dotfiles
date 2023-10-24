require("gitsigns").setup({
  signs = {
    add = { hl = "DiffAdd", text = " ", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = " ", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = " ", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChange", text = " ", numhl = "GitSignsChangeNr" },

    -- add = { hl = "DiffAdd", numhl = "GitSignsAddNr" },
    -- change = { hl = "GitSignsChange", numhl = "GitSignsChangeNr" },
    -- delete = { hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    -- topdelete = { hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    -- changedelete = { hl = "DiffChange", numhl = "GitSignsChangeNr" },
  },
  watch_gitdir = {
    interval = 1000,
  },
  -- current_line_blame = true,
  -- sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  -- use_decoration_api = true,
  -- use_internal_diff = true,
})
