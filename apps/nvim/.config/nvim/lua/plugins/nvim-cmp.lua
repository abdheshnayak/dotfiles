local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
luasnip.config.set_config({
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})

local log = require("plenary.log").new({ plugin = "cmp", level = "debug" })

cmp.register_source("goimports", require("plugins.cmp-sources.go-imports"))

cmp.setup({
  performance = {
    debounce = 50,
    throttle = 10,
  },

  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col >= 0 then
          local lineText = table.concat(vim.api.nvim_buf_get_text(0, line - 1, col - 1, line - 1, col, {}), ",")
          if cmp.visible() then
            if lineText == "{" or lineText == "(" or lineText == "[" then
              fallback()
              return
            end
          end
        end

        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          return
        end
        fallback()
      end,
    }),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand() then
        luasnip.expand()
        return
      end

      -- if require("copilot.suggestion").is_visible() then
      --   require("copilot.suggestion").accept()
      --   return
      -- end

      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
        return
      end

      if cmp.visible() then
        return
      end

      if has_words_before() then
        cmp.complete()
        return
      end

      fallback()
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
        return
      end

      if cmp.visible then
        cmp.select_prev_item()
      end

      fallback()
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp",   priority = 80 },
    { name = "nvim_lua",   priority = 80 },
    { name = "luasnip",    options = { show_autosnippets = true }, priority = 70 },
    { name = "goimports",  priority = 60,                          keyword_length = 3 },
    { name = "async_path", priority = 50 },
    {
      name = "buffer",
      priority = 40,
      keyword_length = 3,
      group_index = 5,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    {
      name = "rg",
      priority = 40,
      keyword_length = 3,
      group_index = 5,
      option = {
        additional_arguments = "--max-depth 6 --one-file-system --ignore-file ~/.config/nvim/scripts/rgignore",
      },
    },
  }),
  -- sorting = {
  -- 	priority_weight = 2,
  -- 	comparators = {
  -- 		cmp.config.compare.order,
  -- 		cmp.config.compare.locality,
  -- 		cmp.config.compare.recently_used,
  -- 		cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
  -- 		cmp.config.compare.offset,
  -- 		-- require("cmp_tabnine.compare"),
  -- 	},
  -- },

  -- copied from TJ Devries (https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155)
  -- sorting = {
  --   -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
  --   comparators = {
  --     cmp.config.compare.offset,
  --     cmp.config.compare.exact,
  --     cmp.config.compare.score,
  --
  --     -- copied from cmp-under, but I don't think I need the plugin for this.
  --     -- I might add some more of my own.
  --     function(entry1, entry2)
  --       local _, entry1_under = entry1.completion_item.label:find("^_+")
  --       local _, entry2_under = entry2.completion_item.label:find("^_+")
  --       entry1_under = entry1_under or 0
  --       entry2_under = entry2_under or 0
  --       if entry1_under > entry2_under then
  --         return false
  --       elseif entry1_under < entry2_under then
  --         return true
  --       end
  --     end,
  --
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local menu = ({
        buffer = "buffer",
        nvim_lsp = "lsp",
        luasnip = "✄ luaSnip",
        nvim_lua = "lua",
        latex_symbols = "laTeX",

        codeium = "⚡",
        rg = "rg",

        fuzzy_buffer = "fzf",
        cmp_tabnine = "⚡",
        treesitter = "treesitter",
        nvim_lsp_signature_help = "lsp signature",
        path = "path",
        tmux = "tmux",
        goimports = "🥅 Go-Imports",
        copilot = "CoPilot",
      })[entry.source.name]

      local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "Ω") .. " "

      if entry.source.name == "cmdline" then
        kind.kind = " ❯⚊ "
      end

      -- kind.menu = "    (" .. (strings[2] or "") .. ")"
      kind.menu = "    (" .. (menu or "Ω") .. ")"

      local item = entry:get_completion_item()
      if item.detail then
        kind.menu = kind.menu .. " 👉 " .. item.detail
      end

      return kind
    end,
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- cmp.setup.cmdline({ "/" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = "buffer" },
--     { name = "path" },
--   }),
-- })

-- cmp.setup.cmdline({ ":" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     -- { name = "cmdline" },
--   }),
-- })
