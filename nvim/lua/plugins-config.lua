vim.cmd([[set completeopt=menu,menuone,noselect]]) -- nvim-cmp

-- formatter.nvim
require("formatter").setup({
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		javascript = { require("formatter.filetypes.javascript").prettierd },
		typescript = { require("formatter.filetypes.typescript").prettierd },
		html = { require("formatter.filetypes.html").prettierd },
		css = { require("formatter.filetypes.css").prettierd },
		zig = { require("formatter.filetypes.zig").zigfmt },
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
	},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
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
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "kj", [[<C-\><C-n>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.keymap.set("n", "<leader>tg", function()
	require("toggleterm.terminal").Terminal
		:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
		})
		:toggle()
end, { noremap = true, silent = true })
