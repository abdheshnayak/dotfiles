local M = {}

M.trim = function(s) 
	return s:gsub("^%s*(.-)%s*$", "%1")
end

M.camel_case = function(str)
  local camelCased = ""
  local wasSeparator = false
  for i = 1, #str do
    local char = str:sub(i, i)
    if not char:match("%a") then
      wasSeparator = true
    else
      camelCased = camelCased .. (wasSeparator and char:upper() or char)
      wasSeparator = false
    end
  end
  return camelCased
end

M.snake_case = function(str, opts)
  opts = opts or { all_lowercase = true, all_uppercase = false }
  local snakeCased = str:sub(1, 1)
  local prevChar = str:sub(1, 1)
  for i = 2, #str - 1 do
    local char = str:sub(i, i)
    local nextChar = str:sub(i + 1, i + 1)

    if not char:match("%u") and nextChar:match("%u") then
      snakeCased = snakeCased .. char .. "_"
    else
      snakeCased = snakeCased .. char
    end
  end

  snakeCased = snakeCased .. str:sub(#str, #str)

  if opts.all_uppercase then
    return string.upper(snakeCased)
  end
  return string.lower(snakeCased)
end

M.snake_case_all_lowercase = function(str)
  return M.snake_case(str, { all_lowercase = true })
end

M.snake_case_all_uppercase = function(str)
  return M.snake_case(str, { all_uppercase = true })
end

return M
