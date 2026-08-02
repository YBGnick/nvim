vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/Weissle/persistent-breakpoints.nvim" })
vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })
vim.pack.add({ "https://github.com/chrisgrieser/nvim-chainsaw" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/theHamsta/nvim-dap-virtual-text" })

local dap = require("dap")
require("nvim-dap-virtual-text").setup()
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

dap.configurations.cppm = {
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
vim.keymap.set("n", "<leader>dc", function() require 'dap'.run_last() end, { desc = "run session" })


vim.keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<cr>", { desc = "dap view" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<cr>", { desc = "watch" })

local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        if keymap.rhs then
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        elseif keymap.callback then
            vim.keymap.set(
                keymap.mode,
                keymap.lhs,
                keymap.callback,
                { buffer = keymap.buffer, silent = keymap.silent == 1 }
            )
        end
    end
    keymap_restore = {}
end
