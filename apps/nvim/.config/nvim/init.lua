-- disabling builtin plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- sourced from `https://nanotipsforvim.prose.sh/using-pcall-to-make-your-config-more-stable`
local function safeRequire(module)
  local success, loadedModule = pcall(require, module)
  if success then
    return loadedModule
  end
  vim.cmd.echo("Error loading " .. module)
end

safeRequire("globals")
safeRequire("settings")
safeRequire("autocmds")
safeRequire("keymaps")
safeRequire("plugins-lazy").minimal()
safeRequire("functions")
safeRequire("commands")

-- vim.cmd("command! -buffer -nargs=0 EslintFix :silent %!eslint_d --fix -")

-- infinite redrawing fixes `neovim + tmux + kitty` as they run into some serious rendering issues
-- it might also be having some serious performance issues
local timer = vim.loop.new_timer()
if timer ~= nil then
  timer:start(
    1000,
    500,
    vim.schedule_wrap(function()
      local currMode = vim.fn.mode()
      if vim.bo.filetype ~= "" then
        vim.cmd("redraw!")
      end
      if currMode == "i" then
        vim.cmd("startinsert")
      end
    end)
  )
end
