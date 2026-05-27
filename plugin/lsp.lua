vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/zeioth/garbage-day.nvim" })
vim.pack.add({ "https://github.com/rshkarin/mason-nvim-lint" })
vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

require('mason').setup {
}
require("mason-lspconfig").setup {
  automatic_enable = true,
  ensure_installed = {
    "buf_ls",
    "lua_ls",
    "bacon_ls",
    "clangd",
    "neocmake",
  }
}

require("lint").linters_by_ft = {
  cpp = {
    "cpplint",
    "codespell",
  },
  hpp = {
    "cpplint",
    "codespell",
  },
  tpp = {
    "cpplint",
    "codespell",
  }
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    require("lint").try_lint()
  end,
})
