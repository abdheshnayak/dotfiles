local nls = require("null-ls")

-- Configuring null-ls
nls.setup({
  sources = {
    -- eslint
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.code_actions.eslint_d,
    nls.builtins.formatting.eslint_d,

    nls.builtins.formatting.stylua,

    -- nls.builtins.completion.spell,
    nls.builtins.code_actions.refactoring,
    -- nls.builtins.diagnostics.golangci_lint,

    nls.builtins.formatting.terraform_fmt,
  },
})

--[[
golangci-lint: (AUR) `yay golangci-lint`
--]]
