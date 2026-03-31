vim.pack.add({"https://github.com/stevearc/oil.nvim"})

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>",{silent = true, buffer = bufnr, desc = "oil"})
