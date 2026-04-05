local bufnr = vim.api.nvim_get_current_buf()
local map = vim.keymap


map.set("n", "<localleader>gi", "<cmd>GoIfErr<cr>", {silent = true, buffer = bufnr, desc = "generate if err"})
map.set("n", "<localleader>gs", "<cmd>GoFillStruct<cr>", {silent = true, buffer = bufnr, desc = "generate fill structs"})
map.set("n", "<localleader>gS", "<cmd>GoFixPlurals<cr>", {silent = true, buffer = bufnr, desc = "generate fill switch"})
map.set("n", "<localleader>gr", "<cmd>GoGenReturn<cr>", {silent = true, buffer = bufnr, desc = "generate return"})
map.set("n", "<localleader>gi", "<cmd>GoImpl<cr>", {silent = true, buffer = bufnr, desc = "generate impl"})
map.set("n", "<localleader>ge", "<cmd>GoEnum<cr>", {silent = true, buffer = bufnr, desc = "generate enum"})
map.set("n", "<localleader>gj", "<cmd>GoJson2Struct<cr>", {silent = true, buffer = bufnr, desc = "generate json to struct"})
map.set("n", "<localleader>gm", "<cmd>GoMockGen<cr>", {silent = true, buffer = bufnr, desc = "generate mock gen"})
map.set("n", "<localleader>gn", "<cmd>GoNew<cr>", {silent = true, buffer = bufnr, desc = "generate new file"})

map.set("n", "<localleader>d", "<cmd>GoDoc<cr>", {silent = true, buffer = bufnr, desc = "docs"})
map.set("n", "<localleader>c", "<cmd>GoCheat<cr>", {silent = true, buffer = bufnr, desc = "cheat"})
map.set("n", "<localleader>a", "<cmd>GoAlt<cr>", {silent = true, buffer = bufnr, desc = "alt"})
map.set("n", "<localleader>o", "<cmd>GoPkgOutline<cr>", {silent = true, buffer = bufnr, desc = "pkg outline"})
map.set("n", "<localleader>s", "<cmd>GoPkgSymbols<cr>", {silent = true, buffer = bufnr, desc = "pkg symbols"})

map.set("n", "<localleader>t", "<cmd>GoModTidy<cr>", {silent = true, buffer = bufnr, desc = "mod tidy"})
map.set("n", "<localleader>v", "<cmd>GoModVendor<cr>", {silent = true, buffer = bufnr, desc = "mod vendor"})
map.set("n", "<localleader>g", "<cmd>GoGet<cr>", {silent = true, buffer = bufnr, desc = "get"})
map.set("n", "<localleader>w", "<cmd>GoWork<cr>", {silent = true, buffer = bufnr, desc = "work"})
map.set("n", "<localleader>r", "<cmd>Gomvp<cr>", {silent = true, buffer = bufnr, desc = "mvp"})
map.set("n", "<localleader>V", "<cmd>GoVulnCheck<cr>", {silent = true, buffer = bufnr, desc = "vuln check"})

local wk = require("which-key")
wk.add({
  {"<localleader>g", desc = "generate"},
})
