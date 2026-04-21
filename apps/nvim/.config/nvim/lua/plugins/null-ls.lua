local null_ls = require("null-ls")
local api = vim.api
local ruff = require("none-ls.diagnostics.ruff")

-- local no_really = {
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = { "markdown", "text", "go" },
-- 	generator = {
-- 		fn = function(params)
-- 			local diagnostics = {}
-- 			-- sources have access to a params object
-- 			-- containing info about the current file and editor state
-- 			for i, line in ipairs(params.content) do
-- 				local col, end_col = line:find("really")
-- 				if col and end_col then
-- 					-- null-ls fills in undefined positions
-- 					-- and converts source diagnostics into the required format
-- 					table.insert(diagnostics, {
-- 						row = i,
-- 						col = col,
-- 						end_col = end_col,
-- 						source = "no-really",
-- 						message = "Don't use 'really!'",
-- 						severity = 2,
-- 					})
-- 				end
-- 			end
-- 			return diagnostics
-- 		end,
-- 	},
-- }
-- -- null_ls.register(no_really)

-- local frozen_string_actions = {
-- 	method = null_ls.methods.CODE_ACTION,
-- 	filetypes = { "go", "lua", "yaml" },
-- 	generator = {
-- 		fn = function(context)
-- 			frozen_string_literal_comment = "# frozen_string_literal: true"
-- 			first_line = context.content[1]
--
-- 			if first_line ~= frozen_string_literal_comment then
-- 				return {
-- 					{
-- 						title = "🥶Add frozen string literal comment",
-- 						action = function()
-- 							lines = { frozen_string_literal_comment, "", first_line }
-- 							vim.api.nvim_buf_set_lines(context.bufnr, 0, 1, false, lines)
-- 						end,
-- 					},
-- 				}
-- 			end
-- 		end,
-- 	},
-- }
--
-- null_ls.register(frozen_string_actions)

local base64 = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "" },
  generator = {
    fn = function(context)
      return {
        {
          title = "Base64 Encode",
          action = function()
            F().b64Encode()
          end,
        },
        -- {
        -- 	title = "Base64 Decode",
        -- 	action = function()
        -- 		F().b64Encode()
        -- 	end,
        -- },
      }
    end,
  },
}

null_ls.register(base64)

local go_implement_interface = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "go" },
  generator = {
    fn = function(context)
      local d = vim.lsp.diagnostic.get_line_diagnostics()
      for _, v in ipairs(d) do
        if v.code == "InvalidTypeArg" then
          local op = string.gsub(v.message, "(.*(does not implement ))", "")
          op = string.gsub(op, "(( .missing method ).*)", "")
        end
      end
      return {
        {
          title = "Go Implement Interface",
        },
      }
    end,
  },
}

--
local addFieldToStruct = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "go" },
  generator = {
    fn = function(context)
      return {
        {
          title = "Add Field to struct",
          action = function()
            R("nxtcoder17.functions.dev").AddFieldToStruct("newfield", "int")
          end,
        },
      }
    end,
  },
}

null_ls.register(addFieldToStruct)

local implementInterface = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "go" },
  generator = {
    fn = function(context)
      return {
        {
          title = "Implment interface on a type",
          action = function()
            require("telescope").extensions.goimpl.goimpl()
          end,
        },
      }
    end,
  },
}

null_ls.register(implementInterface)

local formatBuffer = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "*" },
  generator = {
    fn = function(context)
      return {
        {
          title = "Format Buffer",
          action = function()
            vim.lsp.buf.format({ async = true })
          end,
        },
      }
    end,
  },
}

null_ls.register(formatBuffer)

-- Configuring null-ls
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    ruff,
    null_ls.builtins.formatting.djlint.with({
      extra_args = { "--profile", "django" },
    }),
  },
  on_attach = function(client, bufnr)
    -- Optional: format on save
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.format({
    --       async = false,
    --       filter = function(client)
    --         return client.name == "null-ls"
    --       end,
    --     })
    --   end,
    -- })
  end,
})

--[[ golangci-lint: (AUR) `yay golangci-lint` ]]
