local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local snippets, autosnippets = {}, {}

local try_catch = s(
  "try-catch",
  fmt(
    [[
try {{
  {}
}} catch {{
  {}
}}
]]   ,
    {
      i(1, "// try block"),
      i(2, "throw new error()")
    }
  )
)

table.insert(snippets, try_catch)
