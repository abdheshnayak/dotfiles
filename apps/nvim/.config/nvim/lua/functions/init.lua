_G.R = function(pkg)
  package.loaded[pkg or "vision.functions.dev"] = nil
  return require(pkg or "vision.functions.dev")
end

_G.Fn = function()
  return R("vision.functions")
end

-- _G.OffLoad = function(pkg)
--   if pkg ~= "" then
--     package.loaded[pkg] = nil
--     _G[pkg] = nil
--     print(string.format("pkg %s offload", pkg))
--   end
-- end
