vim.cmd([[set completeopt=menu,menuone,noselect]]) -- nvim-cmp

-- formatter.nvim
require("formatter").setup({
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		javascript = { require("formatter.filetypes.javascript").prettierd },
		typescript = { require("formatter.filetypes.typescript").prettierd },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
		html = { require("formatter.filetypes.html").prettierd },
		css = { require("formatter.filetypes.css").prettierd },
		zig = { require("formatter.filetypes.zig").zigfmt },
		python = { require("formatter.filetypes.python").yapf },
		nim = {
			function()
				return {
					exe = "nimpretty",
					args = { "--indent:2" },
				}
			end,
		},
	},
})

-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"typescript",
		"html",
		"javascript",
		"css",
		"php",
		"zig",
		"python",
	},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = true },
	autotag = { enable = true },
	indent = { enable = false },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 700,
	},
})
