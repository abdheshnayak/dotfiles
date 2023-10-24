require("mason-tool-installer").setup({
  ensure_installed = {
    "lua-language-server",
    "stylua",

    "typescript-language-server",
    "tailwindcss-language-server",
    "eslint_d",

    "bash-language-server",
    "dockerfile-language-server",
    "shellcheck",
    "shfmt",

    "gopls",
    "gofumpt",
    "delve",
    "gotests",
    "gomodifytags",
    "impl",
    "iferr",

    "graphql-language-service-cli",
    "dockerfile-language-server",

    "pyright",
  },
})
