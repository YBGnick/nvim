vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/zeioth/garbage-day.nvim" })
vim.pack.add({ "https://github.com/rshkarin/mason-nvim-lint" })
vim.pack.add({ "https://github.com/antosha417/nvim-lsp-file-operations" })

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

vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--experimental-modules-support",
        "--query-driver=/usr/bin/clang++,/usr/bin/g++,/usr/bin/c++", -- 👈 CRITICAL FOR STDLIB HEADERS
    },
})

require('lint').linters_by_ft = {
    cpp = { "clangtidy", "cppcheck" }
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })



vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})

require("lsp-file-operations").setup()
