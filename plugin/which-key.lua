vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup()

require("which-key").add({
    { "<leader>x",  group = "diagnostics" },
    { "<leader>f",  group = "files" },
    { "<leader>p",  group = "packages" },
    { "<leader>g",  group = "grapple" },
    { "<leader>G",  group = "grub" },
    { "<leader>l",  group = "lsp" },
    { "<leader>c",  group = "cpp" },
    { "<leader>a",  group = "AI" },
    { "<leader>ll", group = "lsp menu" },
    { "<leader>T",  group = "test" },
    { "<leader>o",  group = "overseer" },
    { "<leader>d",  group = "dap" },
    { "<leader>dd", group = "dap menu" },
    { "<leader>m",  group = "misc" },
    { "<leader>r",  group = "refactor" },
    { "<leader>h",  group = "header" },
    { "<leader>D",  group = "docs" },
})
