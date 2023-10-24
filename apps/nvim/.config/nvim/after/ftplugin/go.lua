vim.treesitter.query.set(
  "go",
  "folds",
  [[
    (method_declaration (block) @fold)
  ]]
)
