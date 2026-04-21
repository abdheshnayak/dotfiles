local M = {}

function M.setup()
  -- Infinite redrawing workaround for neovim + tmux + kitty rendering issues.
  local timer = vim.loop.new_timer()
  if timer == nil then
    return
  end

  timer:start(
    1000,
    500,
    vim.schedule_wrap(function()
      local current_mode = vim.fn.mode()
      if vim.bo.filetype ~= "" then
        vim.cmd("redraw!")
      end
      if current_mode == "i" then
        vim.cmd("startinsert")
      end
    end)
  )
end

return M
