vim.pack.add({"https://github.com/stevearc/overseer.nvim"})

require("overseer").setup {
}

vim.keymap.set("n", "<leader>oo", "<cmd>OverseerToggle right<cr>", {desc = "menu"})
vim.keymap.set("n", "<leader>ot", "<cmd>OverseerTaskAction<cr>", {desc = "task action"})
vim.keymap.set("n", "<leader>os", "<cmd>OverseerShell<cr>", {desc = "shell"})
vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", {desc = "run"})
