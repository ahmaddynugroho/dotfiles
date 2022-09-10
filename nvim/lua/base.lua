vim.g.context_enabled = 0

vim.opt.termguicolors = true

-- Nord
vim.g.nord_contrast = true
vim.g.nord_disable_background = true
require("nord").set()

-- Autoread
vim.cmd("set autoread")
vim.cmd("au CursorHold,CursorHoldI * checktime")
vim.cmd("au FocusGained,BufEnter * :checktime")

vim.opt.shortmess = "I"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.lazyredraw = true

-- Neovide
vim.cmd('set guifont=MesloLGM_NF:h10')
