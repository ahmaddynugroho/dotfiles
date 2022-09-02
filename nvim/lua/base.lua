vim.g.context_enabled = 0

vim.opt.termguicolors = true
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = true
vim.cmd("colorscheme tokyonight")

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
