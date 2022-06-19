vim.cmd([[set completeopt=menu,menuone,noselect]]) -- nvim-cmp
require("formatter").setup({
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		javascript = { require("formatter.filetypes.javascript").prettierd },
		typescript = { require("formatter.filetypes.typescript").prettierd },
		html = { require("formatter.filetypes.html").prettierd },
	},
})
