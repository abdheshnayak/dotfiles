local sts = require("syntax-tree-surfer")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<M-v>", function() -- only jump to variable_declarations
  -- sts.targeted_jump({ "variable_declaration" })
  sts.filtered_jump({ "variable_declaration" }, true)
end, opts)

vim.keymap.set("n", "<M-f>", function() -- only jump to functions
  sts.targeted_jump({ "function", "arrrow_function", "function_definition" })
  --> In this example, the Lua language schema uses "function",
  --  when the Python language uses "function_definition"
  --  we include both, so this keymap will work on both languages
end, opts)

vim.keymap.set("n", "<A-m>", function()
  sts.filtered_jump("default", true) --> true means jump forward
end, opts)

vim.keymap.set("n", "<C-j>", function() -- jump to all that you specify
  sts.filtered_jump({
    "import_declaration",
    "type_declaration",
    "function_declration",
    "method_declaration",
    "const_declaration",

    "if_statement",
    "else_statement",
    "return_statement",
    "for_statement",
    "switch_statement",
  }, true)
end, opts)

vim.keymap.set("n", "<C-S-j>", function()
  sts.filtered_jump({
    "import_declaration",
    "type_declaration",
    "function_declaration",
    "method_declaration",
    "const_declaration",
  }, true)
end)

vim.keymap.set("n", "<C-k>", function() -- jump to all that you specify
  sts.filtered_jump({
    -- "import_declaration",
    -- "type_declaration",
    -- "const_declaration",
    -- "function",
    -- "function_call",
    -- "method_declaration",
    -- "function_declration",
    -- "if_statement",
    -- "else_clause",
    -- "else_statement",
    -- "elseif_statement",
    -- "for_statement",
    -- "while_statement",
    -- "switch_statement",

    "import_declaration",
    "type_declaration",
    "function_declration",
    "method_declaration",
    "const_declaration",

    "if_statement",
    "else_statement",
    "return_statement",
    "for_statement",
    "switch_statement",
  }, false)
end, opts)

vim.keymap.set("n", "<C-S-k>", function()
  sts.filtered_jump({
    "import_declaration",
    "type_declaration",
    "function_declaration",
    "method_declaration",
    "const_declaration",
  }, false)
end)
