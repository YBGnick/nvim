vim.pack.add({
  "https://github.com/civitasv/cmake-tools.nvim",
  "https://git.sr.ht/~chinmay/clangd_extensions.nvim",
  "https://github.com/attilarepka/header.nvim",
  "https://github.com/RaafatTurki/hex.nvim",
  "https://github.com/NickTsaizer/splitasm.nvim"
})

require("header").setup({
  license_from_file = true
})

local header = require("header")

vim.keymap.set("n", "<leader>hh", function() header.add_headers() end)
require("clangd_extensions").setup()
require("cmake-tools").setup {
  cmake_build_directory = "build/${variant:buildType}",
  cmake_soft_link_compile_commands = true, -- auto-symlinks compile_commands.json
  cmake_compile_commands_from_lsp = true,
  cmake_kits_path = vim.fn.stdpath("data") .. "/cmake-kits.json",
}

require("splitasm").setup()
require("hex").setup()
