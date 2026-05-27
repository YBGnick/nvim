vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/Weissle/persistent-breakpoints.nvim" })
vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })
vim.pack.add({ "https://github.com/chrisgrieser/nvim-chainsaw" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })

local dap = require("dap")
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

vim.keymap.set("n", "<leader>db", function() require 'dap'.toggle_breakpoint() end, { desc = "breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require 'dap'.continue() end, { desc = "breakpoint" })
vim.keymap.set("n", "<leader>ds", function() require 'dap'.step_over() end, { desc = "step over" })
vim.keymap.set("n", "<leader>dS", function() require 'dap'.step_into() end, { desc = "step into" })
vim.keymap.set("n", "<leader>dr", function() require 'dap'.repl.open() end, { desc = "open REPL" })
vim.keymap.set("n", "<leader>dd", "<cmd>DapViewToggle<cr>", { desc = "dap view" })
