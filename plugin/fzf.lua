vim.pack.add({"https://github.com/ibhagwan/fzf-lua"})
vim.pack.add({"https://github.com/nvim-tree/nvim-web-devicons"})

vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, {desc = "find files"})
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").history() end, {desc = "file history"})
