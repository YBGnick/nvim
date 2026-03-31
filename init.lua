local o = vim.opt

o.autoindent = true
o.expandtab = true
o.shiftround = true
o.shiftwidth = 2
o.smarttab = true
o.tabstop = 2

o.hlsearch = true
o.incsearch = true
o.wrap = false
o.number = true
o.relativenumber = true
o.mouse = "a"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, {desc = "pack update" })
