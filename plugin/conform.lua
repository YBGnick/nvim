vim.pack.add({"https://github.com/stevearc/conform.nvim"})


require("conform").setup ({
  formatters_by_ft = {
    rust = {"rustfmt", lsp_format = "fallback"},
  }
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
