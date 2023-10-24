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
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

local stringsFn = require("functions.strings")

local snippets, autosnippets = {}, {}

local var_stmt = s(
  "var",
  c(1, {
    fmta([[ {{- <p1> := <p2> }} ]], {
      p1 = f(function(...)
        local args = ...
        return "$" .. stringsFn.camel_case(args[1][1])
      end, 1),
      p2 = i(1, "var"),
    }),
    fmta([[ {{- <p1> := get . <p2> }} ]], {
      p1 = f(function(...)
        local args = ...
        return "$" .. stringsFn.camel_case(args[1][1])
      end, 1),
      p2 = i(1, "var"),
    }),
  })
)

-- local var_stmt = s(
--   "var",
--   c(1, {
--     fmta([[ {{- <p1> := <p2> }} ]], {
--       p1 = f(function(...)
--         local args = ...
--         return "$" .. stringsFn.camel_case(args[1][1])
--       end, 1),
--       -- choice nodes for position p2
--       p2 = i(1, "var"),
--     }),
--     {
--       fmta([[ {{- <p1> := get . <p2> }} ]], {
--         p1 = f(function(...)
--           local args = ...
--           return "$" .. stringsFn.camel_case(args[1][1])
--         end, 1),
--         -- choice nodes for position p2
--         p2 = i(1, "var"),
--       }),
--     },
--   })
-- )

table.insert(snippets, var_stmt)

return snippets, autosnippets
