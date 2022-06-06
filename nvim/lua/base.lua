vim.g.context_enabled = 0

vim.opt.termguicolors = true
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = true
vim.cmd([[colorscheme tokyonight]])

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.lazyredraw = true

vim.cmd([[autocmd FileType php setlocal autoindent]])
vim.cmd([[set completeopt=menu,menuone,noselect]]) -- nvim-cmp
