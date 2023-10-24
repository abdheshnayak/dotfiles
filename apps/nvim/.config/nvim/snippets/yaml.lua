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

local snippets, autosnippets = {}, {}

local gql_query = s(
	"gql_query",
	fmta(
		[[
---
label: <p1>
query: |+
  <p2>
variables:
  <p3>
---
]],
		{
			p1 = i(1, "query name"),
			p2 = i(2, "gql query"),
			p3 = i(3, "variables"),
		}
	)
)

table.insert(snippets, gql_query)

local k8s_deployment = s(
	"k8s_deployment",
	fmta(
		[[
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: <p1>
  labels:
    app: <p2>
spec:
  replicas: <p3>
  selector:
    matchLabels:
      app: <p4>
  template:
    metadata:
      labels:
        app: <p5>
    spec:
      containers:
      - name: <p6>
        image: <p7>
]],
		{
			p1 = i(1, "sample"),
			p2 = rep(1),
			p3 = i(2, "1"),
			p4 = rep(1),
			p5 = rep(1),
			p6 = i(3, "main"),
			p7 = i(4, "nginx:latest"),
		}
	)
)

local k8s_service = s(
	"k8s_service",
	fmta(
		[[
---	
apiVersion: v1
kind: Service
metadata:
  name: <p1>
  namespace: <p2>
spec:
  selector:
    app: <p3>
  ports:
    - protocol: TCP
      port: <p4>
      targetPort: <p5>
]],
		{
			p1 = i(1, "sample"),
			p2 = i(2, "sample-ns"),
			p3 = rep(1),
			p4 = i(3, "80"),
			p5 = i(4, "3000"),
		}
	)
)

table.insert(snippets, k8s_deployment)
table.insert(snippets, k8s_service)

return snippets, autosnippets
