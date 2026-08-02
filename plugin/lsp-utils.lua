vim.pack.add({ 'https://github.com/chrisgrieser/nvim-lsp-endhints' })
vim.pack.add({ 'https://github.com/kosayoda/nvim-lightbulb' })
vim.pack.add({ 'https://github.com/romus204/referencer.nvim' })
vim.pack.add({ "https://github.com/VidocqH/lsp-lens.nvim" })
vim.pack.add({ "https://github.com/rachartier/tiny-code-action.nvim" })
vim.pack.add({
    "https://github.com/rmagatti/goto-preview",
    "https://github.com/rmagatti/logger.nvim",
    "https://github.com/Bekaboo/dropbar.nvim"
})

require('lsp-endhints').setup()
require('nvim-lightbulb').setup({
    autocmd = { enabled = true }
})
require('goto-preview').setup {}
require('referencer').setup()
require('lsp-lens').setup {}

require("tiny-code-action").setup {}


local dropbar_api = require('dropbar.api')
vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })



vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.references() end, { desc = "lsp references" })
vim.keymap.set("n", "<leader>lI", function() vim.lsp.buf.implementation() end, { desc = "lsp implementation" })
vim.keymap.set("n", "<leader>lO", function() vim.lsp.buf.incoming_calls() end, { desc = "lsp incoming calls" })
vim.keymap.set("n", "<leader>lI", function() vim.lsp.buf.outgoing_calls() end, { desc = "lsp outgoing calls" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.declaration() end, { desc = "lsp declaration" })
vim.keymap.set("n", "ga", function() require("tiny-code-action").code_action() end, { desc = "lsp code action" })
vim.keymap.set("n", "gD", function() vim.lsp.buf.definition() end, { desc = "lsp definition" })
vim.keymap.set("n", "gK", function() vim.lsp.buf.hover() end, { desc = "lsp hover" })
vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, { desc = "lsp rename" })
vim.keymap.set("n", "gT", function() vim.lsp.buf.type_definition() end, { desc = "lsp type definition" })

vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    { desc = "goto preview def" })
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
    { desc = "goto preview typedef" })
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
    { desc = "goto preview impl" })
vim.keymap.set("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
    { desc = "goto preview decl" })
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "goto close all" })
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
    { desc = "goto preview ref" })
