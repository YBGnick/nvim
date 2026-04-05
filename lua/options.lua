local o = vim.opt

o.autoindent = true
o.shiftround = true
o.smarttab = true

o.textwidth = 80
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true

o.hlsearch = true
o.incsearch = true

o.termguicolors = true
o.undofile = true

o.signcolumn = "yes"

o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }


o.breakindent = true

o.wrap = false

o.number = true
o.relativenumber = true

o.mouse = "a"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
