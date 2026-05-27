local M = {}

function M.get_binary()
  local ok, cmake = pcall(require, "cmake-tools")
  if ok then
    local target = cmake.get_launch_target()
    if target then return target end
  end

  return require("utils.binary").get_binary()
end

return M
