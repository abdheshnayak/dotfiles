local M = {}

function M.safe_require(module)
  local ok, loaded = pcall(require, module)
  if ok then
    return loaded
  end

  vim.notify("Error loading module: " .. module, vim.log.levels.ERROR)
  return nil
end

return M
