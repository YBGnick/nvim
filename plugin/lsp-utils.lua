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




vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.references() end, {desc = "lsp references"})
vim.keymap.set("n", "<leader>lI", function() vim.lsp.buf.implementation() end, {desc = "lsp implementation"})
vim.keymap.set("n", "<leader>lO", function() vim.lsp.buf.incoming_calls() end, {desc = "lsp incoming calls"})
vim.keymap.set("n", "<leader>lI", function() vim.lsp.buf.outgoing_calls() end, {desc = "lsp outgoing calls"})
vim.keymap.set("n", "gd", function() vim.lsp.buf.declaration() end, {desc = "lsp declaration"})
vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, {desc = "lsp code action"})
vim.keymap.set("n", "gD", function() vim.lsp.buf.definition() end, {desc = "lsp definition"})
vim.keymap.set("n", "gK", function() vim.lsp.buf.hover() end, {desc = "lsp hover"})
vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, {desc = "lsp rename"})
vim.keymap.set("n", "gT", function() vim.lsp.buf.type_definition() end, {desc = "lsp type definition"})

