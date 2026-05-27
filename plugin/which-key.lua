vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup()

require("which-key").add({
  { "<leader>x",  group = "diagnostics" },
  { "<leader>f",  group = "files" },
  { "<leader>p",  group = "packages" },
  { "<leader>g",  group = "git" },
  { "<leader>l",  group = "lsp" },
  { "<leader>ll", group = "lsp menu" },
  { "<leader>T",  group = "test" },
  { "<leader>o",  group = "overseer" },
  { "<leader>m",  group = "local" },
  { "<leader>d",  group = "dap" },
  { "<leader>dd", group = "dap menu" },
  { "<leader>m",  group = "misc" },
  { "<leader>r",  group = "refactor" },
  { "<leader>h",  group = "header" },
})
