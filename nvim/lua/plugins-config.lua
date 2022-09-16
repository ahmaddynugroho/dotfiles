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
	},
})

-- Auto format
--vim.cmd([[
--augroup FormatAutogroup
--autocmd!
--autocmd BufWritePost * FormatWrite
--augroup END
--]])

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
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 700, -- Do not enable for files with more than n lines, int
	},
})

-- toggleterm
require("toggleterm").setup({
	open_mapping = "<C-\\>",
	direction = "float",
})
vim.keymap.set("n", "<leader>tg", function()
	require("toggleterm.terminal").Terminal
		:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
		})
		:toggle()
end, { noremap = true, silent = true })
