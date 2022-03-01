require("formatter").setup({
  logging = true,
  filetype = {
    sh = {
      function()
        return {
          exe = "shfmt",
          args = {
            "-i",
            "2",
            "-s",
            "-w",
            "-ci",
          },
          stdin = false,
        }
      end,
    },
    javascript = {
      function()
        return {
          exe = "eslint_d",
          args = { "--fix" },
          stdin = false,
        }
      end,
    },
    javascriptreact = {
      function()
        return {
          exe = "eslint_d",
          args = { "--fix" },
          stdin = false,
        }
      end,
    },
    json = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    jsonc = {
      function()
        return {
          exe = "eslint_d",
          args = { "--fix" },
          stdin = false,
        }
      end,
    },
    typescript = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    typescriptreact = {
      function()
        return {
          exe = "eslint_d",
          args = { "--fix" },
          stdin = false,
        }
      end,
    },
    html = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    css = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    scss = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    markdown = {
      function()
        return {
          exe = "prettier",
          stdin = false,
        }
      end,
    },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
  },
})

-- AutoFormat on Save
-- vim.api.nvim_exec(
--   [[
-- augroup AutoFormatter
--   autocmd!
--   autocmd BufWritePost *.js,*.jsx,*.json,*.css,*.lua,*.md,*.html :FormatWrite
-- augroup END
-- ]],
--   true
-- )
