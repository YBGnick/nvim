vim.pack.add({"https://github.com/nvim-neotest/neotest"})
vim.pack.add({"https://github.com/nvim-neotest/nvim-nio"})
vim.pack.add({"https://github.com/nvim-lua/plenary.nvim"})
vim.pack.add({"https://github.com/antoinemadec/FixCursorHold.nvim"})



require("neotest").setup {
	adapters = {
	},
	consumers = {
--		overseer = require("neotest.consumers.overseer")
	}
}

vim.keymap.set("n", "<leader>Tr", function()require("neotest").run.run() end, {desc = "run test"})
vim.keymap.set("n", "<leader>TR", function()require("neotest").run.run(vim.fn.expand("%")) end, {desc = "test file"})
vim.keymap.set("n", "<leader>Td", function()require("neotest").run.run({strategy="dap"}) end, {desc = "debug test"})
vim.keymap.set("n", "<leader>Ts", function()require("neotest").run.stop() end, {desc = "stop"})
vim.keymap.set("n", "<leader>Ta", function()require("neotest").run.attach() end, {desc = "attach"})

