local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("installing lazy.nvim")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local events = {
  BufEnter = "BufEnter",
  BufRead = "BufRead",
  UIEnter = "UIEnter",
  InsertEnter = "InsertEnter",
  VeryLazy = "VeryLazy",
}

local function colorschemes()
  return {
    {
      "rebelot/kanagawa.nvim",
      -- lazy = true,
      -- event = events.VeryLazy,
      -- init = function()
      --   require("plugins.kanagawa")
      --   vim.cmd("colorscheme kanagawa")
      -- end,
    },
    {
      "folke/tokyonight.nvim",
      -- event = events.UIEnter,
      -- event = events.VeryLazy,
      -- init = function()
      --   require("plugins.tokyonight")
      --   vim.cmd("colorscheme tokyonight")
      -- end,
    },
    -- {
    --   "savq/melange-nvim",
    --   init = function()
    --     vim.cmd("colorscheme melange")
    --   end,
    -- },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      -- disabled = true,
      events = events.BufRead,
      config = function()
        require("plugins.catppuccin")
        vim.cmd("colorscheme catppuccin")
      end,
    },
    {
      "towolf/vim-helm",
      ft = { "gotmpl", "gotexttmpl", "yaml" },
    },
  }
end

local function fuzzy_finders()
  return {
    ["all"] = {
      {
        "nvim-telescope/telescope.nvim",
        event = events.UIEnter,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended

          -- "edolphin-ydf/goimpl.nvim",
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          { "gbrlsnchs/telescope-lsp-handlers.nvim" },
          { "debugloop/telescope-undo.nvim" },
          { "nvim-telescope/telescope-ui-select.nvim" },
          -- {
          -- 	"nvim-telescope/telescope-smart-history.nvim",
          -- 	requires = {
          -- 		"kkharji/sqlite.lua",
          -- 	},
          -- },
        },
        config = function()
          require("plugins.telescope")

          require("telescope").load_extension("fzf")
          require("telescope").load_extension("undo")
          require("telescope").load_extension("ui-select")
          -- require("telescope").load_extension("goimpl")
          -- require("telescope").load_extension("possession")
          require("telescope").load_extension("lsp_handlers")

          require("keymaps-for-plugins").telescope_keymaps()
        end,
      },

      {
        "ibhagwan/fzf-lua",
        event = events.VeryLazy,
        -- optional for icon support
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require("plugins.fzf-lua")
        end,
      },
    },
    ["minimal"] = {
      {
        "nvim-telescope/telescope.nvim",
        event = events.UIEnter,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended

          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          { "gbrlsnchs/telescope-lsp-handlers.nvim" },
          { "nvim-telescope/telescope-ui-select.nvim" },
          -- {
          --   "nvim-telescope/telescope-smart-history.nvim",
          --   requires = {
          --     "kkharji/sqlite.lua",
          --   },
          -- },
        },
        config = function()
          require("plugins.telescope")
          require("telescope").load_extension("fzf")
          require("telescope").load_extension("lsp_handlers")
          require("telescope").load_extension("ui-select")
          require("keymaps-for-plugins").telescope_keymaps()
        end,
      },

      {
        "ibhagwan/fzf-lua",
        event = events.VeryLazy,
        -- optional for icon support
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require("plugins.fzf-lua")
        end,
      },
    },
  }
end

local function file_managers()
  return {
    {
      "kevinhwang91/rnvimr",
      event = events.UIEnter,
      init = function()
        require("keymaps-for-plugins").rnvimr_keymaps()
      end,
    },
  }
end

local function navigation()
  return {
    ["all"] = {
      {
        "alexghergh/nvim-tmux-navigation",
        event = events.UIEnter,
        init = function()
          require("keymaps-for-plugins").nvim_tmux_navigator_keymaps()
        end,
      },
      {
        "tiagovla/scope.nvim",
        event = events.UIEnter,
        config = function()
          require("scope").setup()
        end,
      },
      { "chaoren/vim-wordmotion", event = events.BufRead },

      -- {
      --   "chrisgrieser/nvim-spider",
      --   event = events.BufRead,
      --   config = function()
      --     require("keymaps-for-plugins").spider_keymaps()
      --   end,
      -- },

      {
        "stevearc/aerial.nvim",
        event = events.BufRead,
        after = "nvim-treesitter",
        config = function()
          require("plugins.aerial")
        end,
      },
    },
    ["minimal"] = {
      {
        "alexghergh/nvim-tmux-navigation",
        event = events.UIEnter,
        init = function()
          require("keymaps-for-plugins").nvim_tmux_navigator_keymaps()
        end,
      },
      {
        "chaoren/vim-wordmotion",
        event = events.BufRead,
        config = function()
          require("keymaps-for-plugins").vim_wordmotion_mappings()
        end,
      },
      -- {
      --   "chrisgrieser/nvim-spider",
      --   lazy = true,
      --   config = function()
      --     require("nvim-spider").setup({
      --       skipInsignificantPunctuation = true
      --     })
      --     require("keymaps-for-plugins").spider_keymaps()
      --   end
      -- },
      -- {
      --   "chrisgrieser/nvim-various-textobjs",
      --   opts = { useDefaultKeymaps = true },
      -- },
      {
        "tiagovla/scope.nvim",
        event = events.UIEnter,
        config = function()
          require("scope").setup()
        end,
      },
    },
  }
end

local function session_managers()
  return {
    {
      "jedrzejboczar/possession.nvim",
      event = events.UIEnter,
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins.possession")
      end,
    },
  }
end

local function syntax()
  return {
    ["all"] = {
      {
        "nvim-treesitter/nvim-treesitter",
        event = events.BufRead,
        config = function()
          require("plugins.treesitter")
        end,
        dependencies = {
          { "nvim-treesitter/nvim-treesitter-refactor" },
          { "nvim-treesitter/nvim-treesitter-textobjects" },
          {
            "JoosepAlviste/nvim-ts-context-commentstring",
          },
          { "p00f/nvim-ts-rainbow" },
          { "nvim-treesitter/playground" },
        },
      },
      {
        "utilyre/sentiment.nvim",
        event = "VeryLazy", -- keep for lazy loading
        config = function()
          require("sentiment").setup({})
        end,
      },

      {
        "nvim-treesitter/nvim-treesitter-context",
        event = events.BufRead,
        dependencies = { "nvim-treesitter" },
        config = function()
          require("treesitter-context").setup()
        end,
      },
      {
        "kevinhwang91/nvim-ufo",
        event = events.BufRead,
        requires = "kevinhwang91/promise-async",
        config = function()
          require("plugins.nvim-ufo")
        end,
      },

      {
        "ziontee113/syntax-tree-surfer",
        dependencies = {
          "nvim-treesitter",
        },
        event = events.BufRead,
        config = function()
          require("plugins.syntax-tree-surfer")
        end,
      },
      { "fladson/vim-kitty", ft = "kitty" },
    },

    ["minimal"] = {
      {
        "nvim-treesitter/nvim-treesitter",
        event = events.BufRead,
        config = function()
          require("plugins.treesitter")
        end,
        dependencies = {
          { "nvim-treesitter/nvim-treesitter-textobjects" },
          { "JoosepAlviste/nvim-ts-context-commentstring" },
          { "nvim-treesitter/playground" },
        },
      },
      {
        "ziontee113/syntax-tree-surfer",
        dependencies = {
          "nvim-treesitter",
        },
        event = events.VeryLazy,
        config = function()
          require("plugins.syntax-tree-surfer")
        end,
      },
      {
        "utilyre/sentiment.nvim",
        event = "VeryLazy", -- keep for lazy loading
        config = function()
          require("sentiment").setup({})
        end,
      },
    },
  }
end

local function lsp()
  return {
    {
      "windwp/nvim-ts-autotag",
      event = events.InsertEnter,
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
    {
      "williamboman/mason.nvim",
      -- event = events.UIEnter,
      opts = {
        ensure_installed = {
          "gopls",
          "bash-language-server",
          "eslint_d",
          "lua-language-server",
          "tailwindcss-language-server",
          "typescript-language-server",
          "stylua",
          "gofumpt",
          "goimports_reviser",
          "golines",
        },
      },
      config = function()
        require("mason").setup()
      end,
      dependencies = {
        {
          "WhoIsSethDaniel/mason-tool-installer.nvim",
          config = function()
            require("plugins.mason-tool-installer")
          end,
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      event = events.BufRead,
      config = function()
        require("plugins.lspconfig")
      end,
      dependencies = {
        { "folke/neodev.nvim", ft = "lua" },
        "williamboman/mason-lspconfig.nvim",
        -- {
        --   "j-hui/fidget.nvim",
        --   tag = "legacy",
        --   config = function()
        --     require("fidget").setup({ window = { blend = 0 } })
        --   end,
        -- },
        "b0o/schemastore.nvim",
        {
          "jose-elias-alvarez/null-ls.nvim",
          config = function()
            require("plugins.null-ls")
          end,
        },
      },
    },
    -- {
    --   "ray-x/go.nvim",
    --   enabled = true,
    --   event = events.BufRead,
    --   config = function()
    --     require("go").setup()
    --   end,
    --   dependencies = {
    --     "ray-x/guihua.lua",
    --   },
    --   ft = "go",
    -- },
    {
      "olexsmir/gopher.nvim",
      ft = "go",
      dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("gopher").setup()
      end,
    },
    {
      "folke/trouble.nvim",
      cmd = {
        "Trouble",
        "TroubleToggle",
        "TroubleRefresh",
      },
      config = function()
        require("trouble").setup({})
      end,
    },
  }
end

local function completions()
  return {
    ["all"] = {
      {
        "hrsh7th/nvim-cmp",
        event = events.InsertEnter,
        config = function()
          require("plugins.nvim-cmp")
        end,
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("plugins.luasnip")
              require("keymaps-for-plugins").luasnip_keymaps()
            end,
          },
          {
            "dcampos/cmp-emmet-vim",
            event = events.BufRead,
            ft = { "html", "javascriptreact", "typescriptreact" },
            dependencies = {
              "mattn/emmet-vim",
            },
          },
          { "hrsh7th/cmp-nvim-lua",               ft = "lua" },
          { "FelipeLema/cmp-async-path" },
          { "onsails/lspkind.nvim" },
          { "saadparwaiz1/cmp_luasnip" },
          { "hrsh7th/cmp-nvim-lsp-signature-help" },
          { "andersevenrud/cmp-tmux" },
          -- {
          --   "tzachar/cmp-tabnine",
          --   run = "./install.sh",
          --   config = function()
          --     require("vision.plugins.cmp.tabnine")
          --   end,
          -- },
          { "hrsh7th/cmp-cmdline" },
          { "hrsh7th/cmp-buffer" },
          { "lukas-reineke/cmp-rg" },
          {
            "zbirenbaum/copilot.lua",
            event = events.BufRead,
            config = function()
              require("keymaps-for-plugins").copilot_mappings()
              vim.defer_fn(function()
                require("copilot").setup({
                  panel = { enabled = false },
                  filetypes = {
                    ["*"] = true,
                  },
                  suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                      accept = "<C-CR>",
                      accept_word = false,
                      accept_line = false,
                      -- next = "<M-]>",
                      -- prev = "<M-[>",
                      -- dismiss = "<C-]>",
                      next = "<C-j>",
                      prev = "<C-k>",
                      dismiss = "<C-c>",
                    },
                  },
                })
              end, 100)
            end,
          },
          {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
              require("copilot_cmp").setup()
            end,
          },
        },
      },
      {
        "jcdickinson/codeium.nvim",
        event = events.BufRead,
        dependencies = {
          "nvim-cmp",
          "MunifTanjim/nui.nvim",
        },
        commit = "bb3ede8de30efe01b976eda8342ae4d40a5ee91f",
        config = function()
          require("codeium").setup({})
        end,
      },
      {
        "github/copilot.vim",
        event = events.BufRead,
        config = function()
          require("keymaps-for-plugins").copilot_mappings()
        end,
      },
    },
    ["minimal"] = {
      {
        "hrsh7th/nvim-cmp",
        event = events.InsertEnter,
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          { "lukas-reineke/cmp-rg" },
          { "hrsh7th/cmp-cmdline" },
          { "saadparwaiz1/cmp_luasnip" },
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("plugins.luasnip")
              require("keymaps-for-plugins").luasnip_keymaps()
            end,
          },
          { "onsails/lspkind.nvim" },
        },
        config = function()
          require("plugins.nvim-cmp")
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        event = events.BufRead,
        config = function()
          require("keymaps-for-plugins").copilot_mappings()
          vim.defer_fn(function()
            require("copilot").setup({
              panel = { enabled = false },
              filetypes = {
                ["*"] = true,
              },
              suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = nil,
              },
            })
          end, 100)
        end,
      },
    },
  }
end

local function search_and_replace()
  return {
    {
      "windwp/nvim-spectre",
      event = events.BufRead,
      config = function()
        require("spectre").setup()
      end,
    },
    {
      "mg979/vim-visual-multi",
      -- event = events.BufRead,
      keys = { "<C-n>" },
    },
    {
      "kevinhwang91/nvim-hlslens",
      event = events.VeryLazy,
      config = function()
        require("plugins.nvim-hlslens")
      end,
    },
  }
end

local function flutter()
  return {
    {
      "akinsho/flutter-tools.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- "stevearc/dressing.nvim", -- optional for vim.ui.select
      },
      config = true,
    },
  }
end

local function dap()
  return {
    ["all"] = {
      {
        "mfussenegger/nvim-dap",
        cmd = { "DapContinue" },
        -- event = events.BufRead,
        config = function()
          require("plugins.dap")
        end,
        dependencies = {
          "rcarriga/nvim-dap-ui",
          -- "theHamsta/nvim-dap-virtual-text",
          { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
      },
      {
        "nvim-neotest/neotest",
        wants = {
          "plenary.nvim",
          "nvim-treesitter",
          "FixCursorHold.nvim",
          "neotest-python",
          "neotest-plenary",
          "neotest-go",
          "neotest-jest",
          "neotest-vim-test",
          "neotest-rust",
          "vim-test",
          "overseer.nvim",
        },
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter",
          "antoinemadec/FixCursorHold.nvim",
          -- "nvim-neotest/neotest-python",
          "nvim-neotest/neotest-plenary",
          "nvim-neotest/neotest-go",
          "haydenmeade/neotest-jest",
          -- "nvim-neotest/neotest-vim-test",
          -- "rouge8/neotest-rust",
        },
        cmd = {
          "NeoTest",
          -- "TestNearest",
          -- "TestFile",
          -- "TestSuite",
          -- "TestLast",
          -- "TestVisit",
        },
        config = function()
          require("plugins.neotest").setup()
        end,
      },
      {
        "stevearc/overseer.nvim",
        cmd = {
          "OverseerToggle",
          "OverseerOpen",
          "OverseerRun",
          "OverseerBuild",
          "OverseerClose",
          "OverseerLoadBundle",
          "OverseerSaveBundle",
          "OverseerDeleteBundle",
          "OverseerRunCmd",
          "OverseerQuickAction",
          "OverseerTaskAction",
        },
        config = function()
          require("overseer").setup({
            strategy = "toggleterm",
          })
        end,
      },
    },

    ["minimal"] = {
      {
        "mfussenegger/nvim-dap",
        event = events.VeryLazy,
        config = function()
          require("plugins.dap")
        end,
        dependencies = {
          "rcarriga/nvim-dap-ui",
          -- "theHamsta/nvim-dap-virtual-text",
          -- { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
      },
    },
  }
end

local function terminals()
  return {
    {
      "chomosuke/term-edit.nvim",
      ft = { "toggleterm", "terminal" },
      version = "v1.*",
      config = function()
        require("term-edit").setup({
          prompt_end = "😎 ",
        })
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      event = events.BufRead,
      version = "*",
      config = function()
        require("plugins.toggleterm")
        require("keymaps-for-plugins").toggleterm_keymaps()
      end,
    },
    {
      "samjwill/nvim-unception",
      ft = { "toggleterm", "terminal" },
      init = function()
        vim.g.unception_open_buffer_in_new_tab = true
        -- vim.api.nvim_create_autocmd("User", {
        --   pattern = "UnceptionEditRequestReceived",
        --   callback = function()
        --     -- Toggle the terminal off.
        --     require("toggleterm").toggle()
        --   end,
        -- })
        -- Optional settings go here!
        -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
      end,
    },
  }
end

local function status_and_tab_bars()
  return {
    {
      "nanozuki/tabby.nvim",
      event = events.UIEnter,
      config = function()
        require("tabby").setup()
      end,
    },
    {
      "declancm/maximize.nvim",
      event = events.UIEnter,
      config = function()
        require("maximize").setup()
      end,
    },
  }
end

local function misc()
  return {
    {
      "luukvbaal/stabilize.nvim",
      event = events.BufRead,
      config = function()
        require("stabilize").setup()
      end,
    },
    {
      "echasnovski/mini.nvim",
      event = events.UIEnter,
      branch = "stable",
      config = function()
        require("plugins.mini")
      end,
    },
    {
      "nvchad/nvim-colorizer.lua",
      ft = { "javascriptreact", "css", "html", "javascript", "typescript", "typescriptreact", "svelte", "vue" },
      config = function()
        require("colorizer").setup({
          filetypes = {
            "javascriptreact",
            "css",
            "html",
            "javascript",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
          },
          user_default_options = {
            tailwind = true,
          },
        })
      end,
    },
    {
      "nyngwang/NeoZoom.lua",
      cmd = {
        "NeoZoomToggle",
      },
      config = function()
        require("neo-zoom").setup({})
      end,
    },
    { "ellisonleao/glow.nvim", ft = "markdown", config = true, cmd = "Glow" },
    -- {
    --   "toppair/peek.nvim",
    --   ft = "markdown",
    --   build = "deno task --quiet build:fast",
    --   config = function()
    --     require("plugins.peek-nvim")
    --   end,
    -- },

    -- -- don't need it when noice is enabled
    -- {
    --   "AckslD/messages.nvim",
    --   cmd = {
    --     "Messages",
    --   },
    --   event = events.VeryLazy,
    --   config = function()
    --     require("messages").setup()
    --     _G.Msg = function(...)
    --       require("messages.api").capture_thing(...)
    --     end
    --   end,
    -- },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
          "rcarriga/nvim-notify",
          config = function()
            require("notify").setup({
              render = "minimal",
              stages = "fade",
              timeout = 0,
              background_colour = "#120000",
            })
          end,
        },
      },
      config = function()
        require("plugins.noice")
      end,
    },
  }
end

local function git_clients()
  return {
    {
      "sindrets/diffview.nvim",
      cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewRefresh",
      },
      -- event = events.BufEnter,
    },
    {
      "lewis6991/gitsigns.nvim",
      cmd = {
        "Gitsigns",
      },
      -- event = events.BufRead,
      config = function()
        require("plugins.git-signs")
      end,
    },
  }
end

local M = {}

M.all = function()
  local plugins = {}
  vim.list_extend(plugins, colorschemes())
  vim.list_extend(plugins, fuzzy_finders().all)
  vim.list_extend(plugins, file_managers())
  vim.list_extend(plugins, navigation().all)
  vim.list_extend(plugins, session_managers())
  vim.list_extend(plugins, syntax().all)
  vim.list_extend(plugins, lsp())
  vim.list_extend(plugins, completions().all)
  vim.list_extend(plugins, search_and_replace())
  vim.list_extend(plugins, flutter())
  vim.list_extend(plugins, dap().all)
  vim.list_extend(plugins, terminals())
  vim.list_extend(plugins, status_and_tab_bars())
  vim.list_extend(plugins, misc())
  -- vim.list_extend(plugins, git_clients())

  require("lazy").setup(plugins)
end

M.minimal = function()
  local plugins = {}
  vim.list_extend(plugins, colorschemes())
  vim.list_extend(plugins, fuzzy_finders().minimal)
  vim.list_extend(plugins, file_managers())
  vim.list_extend(plugins, navigation().minimal)
  vim.list_extend(plugins, session_managers())
  vim.list_extend(plugins, syntax().minimal)
  vim.list_extend(plugins, lsp())
  vim.list_extend(plugins, flutter())
  vim.list_extend(plugins, completions().minimal)
  vim.list_extend(plugins, search_and_replace())
  vim.list_extend(plugins, dap().minimal)
  vim.list_extend(plugins, terminals())
  vim.list_extend(plugins, status_and_tab_bars())
  vim.list_extend(plugins, misc())
  vim.list_extend(plugins, git_clients())

  require("lazy").setup(plugins)
end

return M
