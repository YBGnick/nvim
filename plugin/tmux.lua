vim.pack.add({ "https://github.com/aserowy/tmux.nvim" })

vim.keymap.set({ 'n', 'i', 'x' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'i', 'x' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'i', 'x' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'i', 'x' }, '<C-l>', '<C-w>l')

require("tmux").setup()
