vim.pack.add({ "https://github.com/ray-x/go.nvim" })
vim.pack.add({ "https://github.com/ray-x/guihua.lua" })


require("go").setup(opts)
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
