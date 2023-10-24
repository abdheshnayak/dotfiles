local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local types = require("luasnip.util.types")

require("luasnip.loaders.from_lua").load({
  paths = {
    vim.g.nvim_dir .. "/snippets",
    vim.g.root_dir .. "/.tools/snippets",
    vim.g.root_dir .. "/.nvim/snippets",
  },
})

ls.setup({
  history = true,
  enable_autosnippets = true,
  update_events = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        -- virt_text = { { "●", "GruvboxOrange" } },
        virt_text = { { "●", "@keyword.operator" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "@method.call" } },
      },
    },
  },
})

require("luasnip.loaders.from_snipmate").lazy_load({
  paths = {
    vim.g.nvim_dir .. "/snippets",
    vim.g.root_dir .. "/.tools/snippets",
    vim.g.root_dir .. "/.nvim/snippets",
  }
})
