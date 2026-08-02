vim.pack.add({ "https://codeberg.org/jthvai/lavender.nvim" })
vim.pack.add({ "https://github.com/xiyaowong/transparent.nvim" })
vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }
vim.pack.add({ "https://github.com/daedlock/matugen.nvim" })
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })

-- require("matugen").setup({
--     colors_path = "~/.config/noctalia/colors.json",
-- })
--
-- require("catppuccin").setup {
--     flavour = "mocha"
-- }

vim.cmd "colorscheme kanagawa-dragon"
