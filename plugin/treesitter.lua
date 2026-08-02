vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter"
})

require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { 'c', 'cpp', 'cmake' }

vim.treesitter.language.add('cpp', { 'cppm' })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cppm', 'cpp', 'c', 'txt' },
    callback = function() vim.treesitter.start() end,
})


vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
