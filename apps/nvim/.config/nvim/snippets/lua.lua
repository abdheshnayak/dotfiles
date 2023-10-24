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

local snippets, autosnippets = {}, {}

local nSnippet = s("nSnippet", fmt("hi hello", {}), {})
table.insert(snippets, nSnippet)

local fn = s(
  "fn",
  fmt(
    [[
    local function {}({})
    {}
    end
  ]],
    {
      i(1, "myFn"),
      i(2, "args"),
      -- c(2, {
      --   { t("args") },
      --   { t("{}") },
      -- }),
      i(3, "-- todo:"),
    }
  )
)
table.insert(snippets, fn)

local fn2 = s(
  "fn2",
  fmt(
    [[
local function {}({})
  {}
end
]],
    {
      i(1, "myFn"),
      i(2, "args"),
      d(3, function(args)
        return sn(nil, i(1, string.upper(args[1][1])))
      end, { 1 }),
    }
  )
)
table.insert(snippets, fn2)

return snippets, autosnippets
