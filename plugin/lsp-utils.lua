vim.pack.add({'https://github.com/chrisgrieser/nvim-lsp-endhints'})
vim.pack.add({'https://github.com/kosayoda/nvim-lightbulb'})
vim.pack.add({'https://github.com/romus204/referencer.nvim'})
vim.pack.add({"https://github.com/VidocqH/lsp-lens.nvim"})

require('lsp-endhints').setup()
require('nvim-lightbulb').setup({
	autocmd = {enabled = true }
})
require('referencer').setup()
require('lsp-lens').setup {}
