-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/vision/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/vision/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/vision/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/vision/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/vision/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-session"] = {
    config = { "\27LJ\2\n×\2\0\0\6\0\15\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0=\3\t\0026\3\0\0009\3\n\0039\3\v\3'\5\f\0B\3\2\2'\4\r\0&\3\4\3=\3\14\2B\0\2\1K\0\1\0\26auto_session_root_dir\15/sessions/\tdata\fstdpath\afn\31auto_session_suppress_dirs\1\2\0\0\a~/\1\0\3\25auto_session_enabled\2\14log_level\tinfo\25auto_restore_enabled\2\nsetup\17auto-session\frequire?buffers,curdir,folds,help,tabpages,winsize,winpos,terminal\19sessionoptions\6o\bvim\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["close-buffers.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/close-buffers.nvim",
    url = "https://github.com/kazhala/close-buffers.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-copilot"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.copilot\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-copilot",
    url = "https://github.com/hrsh7th/cmp-copilot"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-snippy"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-snippy",
    url = "https://github.com/dcampos/cmp-snippy"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["crates.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/Saecki/crates.nvim"
  },
  ["diffview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\nW\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\ninput\1\0\0\1\0\1\fenabled\2\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-lua"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.fzf-lua\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["glow.nvim"] = {
    config = { "\27LJ\2\n‚\1\0\0\4\0\t\0\0156\0\0\0009\0\1\0006\1\0\0009\1\3\0019\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0K\0\1\0\frounded\16glow_border\bbin\tdata\fstdpath\afn\21glow_binary_path\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["go.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ago\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["graphql-cli"] = {
    config = { "\27LJ\2\nZ\0\0\5\0\a\0\b6\0\0\0009\0\1\0'\2\2\0006\3\3\0009\3\4\0039\3\5\3'\4\6\0D\0\4\0\23.tools/gqlenv.json\bPWD\benv\bvim\n%s/%s\vformat\vstring]\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\1K\0\1\0\fenvFile\0\1\0\1\fcommand\bGql\nsetup\16graphql-cli\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/graphql-cli",
    url = "https://github.com/nxtcoder17/graphql-cli"
  },
  ["i3config.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/i3config.vim",
    url = "https://github.com/mboughaba/i3config.vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nÃ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\3\0\0\thelp\vpacker\1\0\2\tchar\bâ”Š#show_trailing_blankline_indent\2\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["inspect.lua"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/inspect.lua",
    url = "https://github.com/kikito/inspect.lua"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins_dir.colorscheme\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp-colors.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.lualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.null-ls\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nÜ\1\0\0\n\0\f\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\1\18\4\2\0009\2\6\2'\5\a\0009\6\b\0005\b\n\0005\t\t\0=\t\v\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins_dir.nvim-cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\no\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\17nearest_only\2\14calm_down\2\23nearest_float_when\valways\nsetup\fhlslens\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lsp-installer"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "symbols-outline.nvim", "nvim-lsp-installer", "lsp-colors.nvim" },
    config = { "\27LJ\2\n#\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\blsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-markdown-preview"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-markdown-preview",
    url = "https://github.com/davidgranstrom/nvim-markdown-preview"
  },
  ["nvim-snippy"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vsnippy\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-snippy",
    url = "https://github.com/dcampos/nvim-snippy"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fspectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre"
  },
  ["nvim-toggle-terminal"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-toggle-terminal",
    url = "https://github.com/caenrique/nvim-toggle-terminal"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects", "nvim-ts-autotag", "nvim-treesitter-refactor", "nvim-ts-context-commentstring", "playground" },
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins_dir.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\16refactoring\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  rnvimr = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/rnvimr",
    url = "https://github.com/kevinhwang91/rnvimr"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["symbols-outline.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["tabby.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ntabby\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/tabby.nvim",
    url = "https://github.com/nanozuki/tabby.nvim"
  },
  tabular = {
    after_files = { "/home/vision/.local/share/nvim/site/pack/packer/opt/tabular/after/plugin/TabularMaps.vim" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins_dir.telescope\frequire\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins_dir.todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-jsx-pretty"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-jsx-pretty",
    url = "https://github.com/MaxMEllon/vim-jsx-pretty"
  },
  ["vim-kitty"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-kitty",
    url = "https://github.com/fladson/vim-kitty"
  },
  ["vim-kubernetes"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-kubernetes",
    url = "https://github.com/andrewstuart/vim-kubernetes"
  },
  ["vim-lastplace"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-lastplace",
    url = "https://github.com/farmergreg/vim-lastplace"
  },
  ["vim-matchup"] = {
    after_files = { "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/vim-maximizer",
    url = "https://github.com/szw/vim-maximizer"
  },
  ["vim-polyglot"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/vision/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-wordmotion"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vision/.local/share/nvim/site/pack/packer/opt/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n×\2\0\0\6\0\15\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0=\3\t\0026\3\0\0009\3\n\0039\3\v\3'\5\f\0B\3\2\2'\4\r\0&\3\4\3=\3\14\2B\0\2\1K\0\1\0\26auto_session_root_dir\15/sessions/\tdata\fstdpath\afn\31auto_session_suppress_dirs\1\2\0\0\a~/\1\0\3\25auto_session_enabled\2\14log_level\tinfo\25auto_restore_enabled\2\nsetup\17auto-session\frequire?buffers,curdir,folds,help,tabpages,winsize,winpos,terminal\19sessionoptions\6o\bvim\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\nW\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\ninput\1\0\0\1\0\1\fenabled\2\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins_dir.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.null-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: cmp-copilot
time([[Config for cmp-copilot]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins_dir.copilot\frequire\0", "config", "cmp-copilot")
time([[Config for cmp-copilot]], false)
-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins_dir.colorscheme\frequire\0", "config", "kanagawa.nvim")
time([[Config for kanagawa.nvim]], false)
-- Config for: vim-polyglot
time([[Config for vim-polyglot]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-polyglot")
time([[Config for vim-polyglot]], false)
-- Config for: refactoring.nvim
time([[Config for refactoring.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\16refactoring\frequire\0", "config", "refactoring.nvim")
time([[Config for refactoring.nvim]], false)
-- Config for: graphql-cli
time([[Config for graphql-cli]], true)
try_loadstring("\27LJ\2\nZ\0\0\5\0\a\0\b6\0\0\0009\0\1\0'\2\2\0006\3\3\0009\3\4\0039\3\5\3'\4\6\0D\0\4\0\23.tools/gqlenv.json\bPWD\benv\bvim\n%s/%s\vformat\vstring]\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\1K\0\1\0\fenvFile\0\1\0\1\fcommand\bGql\nsetup\16graphql-cli\frequire\0", "config", "graphql-cli")
time([[Config for graphql-cli]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType i3config ++once lua require("packer.load")({'i3config.vim'}, { ft = "i3config" }, _G.packer_plugins)]]
vim.cmd [[au FileType kitty ++once lua require("packer.load")({'vim-kitty'}, { ft = "kitty" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'vim-kubernetes'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-ts-context-commentstring'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-ts-context-commentstring'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'vim-jsx-pretty', 'nvim-ts-context-commentstring'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'vim-jsx-pretty', 'nvim-ts-context-commentstring'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'go.nvim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'glow.nvim', 'nvim-markdown-preview'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'vim-jsx-pretty', 'nvim-treesitter', 'lualine.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-matchup', 'tabby.nvim', 'vim-lastplace'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-colorizer.lua', 'indent-blankline.nvim', 'todo-comments.nvim', 'diffview.nvim', 'nvim-ts-autotag', 'nvim-ts-rainbow'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'vim-visual-multi', 'nvim-lspconfig', 'go.nvim', 'tabular', 'symbols-outline.nvim', 'stabilize.nvim', 'nvim-cmp', 'fzf-lua', 'vim-kubernetes', 'nvim-toggle-terminal', 'nvim-spectre', 'nvim-markdown-preview', 'nvim-hlslens'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'vim-surround', 'nvim-autopairs', 'nvim-snippy', 'vim-wordmotion'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'glow.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]], true)
vim.cmd [[source /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]]
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]], false)
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/i3config.vim/ftdetect/i3config.vim]], true)
vim.cmd [[source /home/vision/.local/share/nvim/site/pack/packer/opt/i3config.vim/ftdetect/i3config.vim]]
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/i3config.vim/ftdetect/i3config.vim]], false)
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kubernetes/ftdetect/kubeconf.vim]], true)
vim.cmd [[source /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kubernetes/ftdetect/kubeconf.vim]]
time([[Sourcing ftdetect script at: /home/vision/.local/share/nvim/site/pack/packer/opt/vim-kubernetes/ftdetect/kubeconf.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(1) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
