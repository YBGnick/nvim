vim.pack.add({ "https://github.com/folke/trouble.nvim" })
vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require 'trouble'.setup()

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, desc = "diagnostics" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { silent = true, desc = "location list" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble quickfix toggle<cr>", { silent = true, desc = "quickfix" })
vim.keymap.set("n", "<leader>lL", "<cmd>Trouble lsp toggle<cr>", { silent = true, desc = "lsp menu" })
