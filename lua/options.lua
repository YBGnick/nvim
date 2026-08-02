local o = vim.opt

o.autoindent = true
o.shiftround = true
o.smarttab = true

o.textwidth = 100
o.shiftwidth = 4
o.tabstop = 4
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

vim.filetype.add({
  extension = {
    tpp = "cpp",
  },
})
