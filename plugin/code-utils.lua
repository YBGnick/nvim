vim.pack.add {
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/andythigpen/nvim-coverage",
    "https://github.com/MagicDuck/grug-far.nvim",
    "https://github.com/laytan/cloak.nvim",
    "https://github.com/cbochs/grapple.nvim",
    "https://github.com/bassamsdata/namu.nvim",
}

require("mini.ai").setup {}
require("mini.align").setup {}
require("mini.comment").setup {}
require("mini.operators").setup {}
require("mini.pairs").setup {}
require("mini.surround").setup {}
require("mini.indentscope").setup {}
require("mini.notify").setup {}
require('grug-far').setup {}
require('cloak').setup {
    enabled = true
}
require('grapple').setup {
    scope = "git"
}

vim.keymap.set("n", "<leader>R", "<cmd>GrugFar<cr>", { desc = "Grug Far" })

vim.keymap.set("n", "<leader>gg", require("grapple").toggle, { desc = "toggle" })
vim.keymap.set("n", "<leader>gG", require("grapple").toggle_tags, { desc = "tags" })

vim.keymap.set("n", "<leader>gn", "<cmd>Grapple cycle_tags next<cr>", { desc = "next" })
vim.keymap.set("n", "<leader>gp", "<cmd>Grapple cycle_tags prev<cr>", { desc = "prev" })

require('namu').setup()


vim.keymap.set("n", "<leader>ss", "<cmd>Namu symbols<cr>", { desc = "symbols" })
vim.keymap.set("n", "<leader>sw", "<cmd>Namu workspace<cr>", { desc = "symbol workspace" })
vim.keymap.set("n", "<leader>sd", "<cmd>Namu diagnostics<cr>", { desc = "diagnostics" })
vim.keymap.set("n", "<leader>sd", "<cmd>Namu ctags<cr>", { desc = "ctaggs" })
