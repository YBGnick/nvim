local map = vim.keymap


map.set("n", "`", "<cmd>ClangdSwitchSourceHeader<cr>", { silent = true, desc = "switch header" })
map.set("n", "<localleader>s", "<cmd>ClangdSwitchSourceHeader<cr>", { silent = true, desc = "switch header" })
map.set("n", "<localleader>a", "<cmd>ClangdAST<cr>", { silent = true, desc = "ast" })
map.set("n", "<localleader>i", "<cmd>ClangdSymbolInfo<cr>", { silent = true, desc = "symbol info" })
map.set("n", "<localleader>t", "<cmd>ClangdTypeHierarchy<cr>", { silent = true, desc = "type info" })
map.set("n", "<localleader>m", "<cmd>ClangdMemoryUsage<cr>", { silent = true, desc = "memory usage" })
