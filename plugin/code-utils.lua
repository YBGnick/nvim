vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
vim.pack.add({ "https://github.com/andythigpen/nvim-coverage" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/lewis6991/async.nvim" })
vim.pack.add({ "https://github.com/ThePrimeagen/refactoring.nvim" })
vim.pack.add({ "https://github.com/danymat/neogen" })
vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })

require("nvim-autopairs").setup {}
require("nvim-surround").setup {}
require("coverage").setup {}
require("refactoring").setup {}
require("neogen").setup { snippet_engine = "luasnip" }
require("notify").setup {
  background_colour = "#00000"
}

vim.notify = require("notify")

vim.keymap.set({ "n", "x" }, "<leader>rs", function()
  require("refactoring").select_refactor()
end, { desc = "Select refactor" })


vim.keymap.set({ "n" }, "<leader>Dg", function()
  require("neogen").generate()
end, { desc = "Generate Docs" })


local opts = { noremap = true, silent = true, desc = "Generate class generation" }
vim.keymap.set("n", "<Leader>Dc", function()
  require('neogen').generate({ type = 'class' })
end, opts)
