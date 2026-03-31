vim.pack.add({"https://github.com/mason-org/mason-lspconfig.nvim"})
vim.pack.add({"https://github.com/mason-org/mason.nvim"})
vim.pack.add({"https://github.com/neovim/nvim-lspconfig"})

require('mason').setup {
}
require("mason-lspconfig").setup {
  automatic_enable = true,
  ensure_installed = {"buf_ls" } 
}

