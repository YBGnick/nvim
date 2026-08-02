vim.pack.add({ "https://github.com/barrettruth/canola.nvim", "https://github.com/ingur/fzf-oil.nvim", })

require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

local browser = require("fzf-oil").setup()

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true, buffer = bufnr, desc = "oil" })
vim.keymap.set("n", "<leader>fb", browser.browse, { desc = "File browser" })
