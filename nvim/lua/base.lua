vim.opt.termguicolors = true
vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true

-- coc
vim.cmd[[
	set hidden
	set nobackup
	set nowritebackup
	set cmdheight=2
	set updatetime=300
	set shortmess+=c
]]
