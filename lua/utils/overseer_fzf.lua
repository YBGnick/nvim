-- lua/utils/overseer_fzf.lua
local M = {}

-- Launch any overseer template through fzf-lua
function M.run_task()
  local overseer = require("overseer")
  local templates = overseer.list_templates()

  local names = vim.tbl_map(function(t) return t.name end, templates)

  require("fzf-lua").fzf_exec(names, {
    prompt  = "Overseer Task > ",
    winopts = { height = 0.4, width = 0.5 },
    actions = {
      ["default"] = function(entry)
        overseer.run_task({ name = entry[1] })
      end,
    },
  })
end

-- Browse running/completed tasks and toggle their output
function M.task_list()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })

  if #tasks == 0 then
    vim.notify("No overseer tasks", vim.log.levels.INFO)
    return
  end

  local entries = vim.tbl_map(function(t)
    local icon = ({
      [overseer.STATUS.RUNNING] = "▶",
      [overseer.STATUS.SUCCESS] = "✔",
      [overseer.STATUS.FAILURE] = "✘",
      [overseer.STATUS.CANCELED] = "◼",
    })[t.status] or "?"
    return string.format("%s  [%s]  %s", icon, t.status, t.name)
  end, tasks)

  require("fzf-lua").fzf_exec(entries, {
    prompt  = "Tasks > ",
    winopts = { height = 0.4, width = 0.6 },
    actions = {
      -- open task output
      ["default"] = function(entry)
        local idx = tonumber(entry[1]:match("^%d+")) or 1
        require("overseer").run_action(tasks[idx], "open output")
      end,
      -- restart task
      ["ctrl-r"] = function(entry)
        local idx = tonumber(entry[1]:match("^%d+")) or 1
        require("overseer").run_action(tasks[idx], "restart")
      end,
      -- dispose task
      ["ctrl-d"] = function(entry)
        local idx = tonumber(entry[1]:match("^%d+")) or 1
        require("overseer").run_action(tasks[idx], "dispose")
      end,
    },
  })
end

return M
