local M = {};

local modes = {
  "n",
  "v",
  "c",
  "i",
  "x",
  "t",
  "s",
  "r",
};

-- iterate over lua table modes

for _, m in ipairs(modes) do
    M[string.format("%smap", m)] = function (key, value, opts)
        vim.api.nvim_set_keymap(m, key, value, opts)
    end

    local globalOpts = { noremap = true, silent = true }
    M[string.format("%snoremap", m)] = function (key, value)
        vim.api.nvim_set_keymap(m, key, value, globalOpts)
    end
end

M.unmap = function (key, mode)
    vim.api.nvim_del_keymap(mode, key)
end


for i, v in ipairs(M) do
    print(i, v);
end

return M;
