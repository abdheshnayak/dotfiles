-- Packer Plugins

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
  -- nvim autopairs
  use("windwp/nvim-autopairs")

  -- vim surround
  use('tpope/vim-surround')

  -- nvim visual multi
  use("mg979/vim-visual-multi")

  -- TextObj
  use("terryma/vim-expand-region")

  use("kana/vim-textobj-user")
  use("kana/vim-textobj-indent")
  use("kana/vim-textobj-line")
  use("kana/vim-textobj-entire")
  use("kana/vim-textobj-function")
  use("kana/vim-textobj-underscore")

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- keybindings are defined in init.vscode.vim
