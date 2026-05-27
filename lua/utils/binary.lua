-- lua/utils/binary.lua
local M = {}

function M.find_binary(build_dir)
  build_dir = build_dir or "build"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local results = {}

  local handle = io.popen(
    string.format("find %s -maxdepth 3 -type f -executable -not -name '*.so' -not -name '*.a' 2>/dev/null", build_dir)
  )
  if not handle then return nil end

  for line in handle:lines() do
    if not line:match("CMakeFiles") and not line:match("%.cmake$") then
      table.insert(results, line)
    end
  end
  handle:close()

  if #results == 0 then return nil end

  for _, path in ipairs(results) do
    if path:match(project_name) then return path end
  end

  if #results > 1 then
    return M.pick_binary(results)
  end

  return results[1]
end

-- fzf-lua picker instead of Telescope
function M.pick_binary(binaries)
  local selected = nil

  require("fzf-lua").fzf_exec(binaries, {
    prompt  = "Select Binary > ",
    actions = {
      ["default"] = function(entry)
        selected = entry[1]
      end,
    },
    -- block until selection is made
    winopts = { height = 0.33, width = 0.5 },
  })

  return selected
end

local _cached_binary = nil

function M.get_binary(force_pick)
  if _cached_binary and not force_pick then
    return _cached_binary
  end

  local binary = M.find_binary()
  if not binary then
    binary = vim.fn.input("Binary path: ", vim.fn.getcwd() .. "/build/", "file")
  end

  _cached_binary = binary
  return binary
end

function M.clear_cache()
  _cached_binary = nil
  vim.notify("Binary cache cleared", vim.log.levels.INFO)
end

return M
