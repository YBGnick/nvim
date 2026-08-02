vim.pack.add({ "https://github.com/carlos-algms/agentic.nvim" })


require("agentic").setup {
    provider = "mistral-vibe-acp"
}


vim.keymap.set("n", "<leader>aa", function() require("agentic").toggle() end, { desc = "toggle" })
vim.keymap.set("n", "<leader>as", function() require("agentic").restore_session() end, { desc = "add selection" })
vim.keymap.set("n", "<leader>af", function() require("agentic").add_file() end, { desc = "add file" })
vim.keymap.set("n", "<leader>ad", function() require("agentic").add_current_line_diagnostics() end,
    { desc = "add line diagnostic" })
vim.keymap.set("n", "<leader>aD", function() require("agentic").add_buffer_diagnostics() end,
    { desc = "add buffer diagnostic" })
vim.keymap.set("n", "<leader>aS", function() require("agentic").stop_generation() end, { desc = "stop generation" })
vim.keymap.set("n", "<leader>aR", function() require("agentic").restore_session() end, { desc = "restore session" })
