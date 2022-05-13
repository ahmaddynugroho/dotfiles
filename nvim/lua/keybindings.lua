local map = require("utils").map
local wk = require("which-key")

vim.g.mapleader = [[,]]
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
map("", "<f1>", "<cmd>FloatermToggle<cr>") -- Disable annoying F1 binding
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("i", "jk", "<ESC>", { noremap = true })
map("i", "kj", "<ESC>", { noremap = true })
map("v", "<", "<gv", { noremap = true, silent = false })
map("v", ">", ">gv", { noremap = true, silent = false })

local toggleterm = [[<C-\>]]
wk.register({
	["<leader>g"] = {
		function()
			Terminal.lazygit:toggle(20, "float")
		end,
		"Lazygit",
	},
	["<leader>n"] = {
		function()
			Terminal.nvim:toggle(20, "float")
		end,
		"Edit neovim config",
	},
}, { noremap = true, silent = true })

wk.register({
	["<leader>q"] = { "<cmd>qa<cr>", "Close all" },
	["<leader>x"] = { "<cmd>bd<cr>", "Close this buffer" },
	["<leader>w"] = { "<cmd>w<cr>", "Save" },
	["<M-j>"] = { ":resize -2<CR>", "Resize horizontal -2" },
	["<M-k>"] = { ":resize +2<CR>", "Resize horizontal +2" },
	["<M-h>"] = { ":vertical resize -2<CR>", "Resize vertical -2" },
	["<M-l>"] = { ":vertical resize +2<CR>", "Resize vertical +2" },
	["<Tab>"] = { ":bnext<CR>", "Next buffer" },
	["<S-Tab>"] = { ":bprevious<CR>", "Previous buffer" },
	["\\"] = { ":Neotree reveal<CR>", "Neotree" },
	["<leader>f"] = {
		name = "+find",
		f = { "<CMD>lua require('telescope.builtin').find_files()<CR>", "File" },
		o = {
			"<CMD>lua require('telescope.builtin').oldfiles()<CR>",
			"Old file (recent)",
		},
		g = {
			"<CMD>lua require('telescope.builtin').live_grep()<CR>",
			"Live grep",
		},
		b = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Buffer" },
		h = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", "Tags" },
	},
}, { silent = true })

local gitsigns_oa = function(bufnr)
	local gs = package.loaded.gitsigns

	local function _map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	_map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

	-- Navigation
	_map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	_map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	wk.register({
		["<leader>h"] = {
			name = "+hunk ops",
			s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
			r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
			S = { gs.stage_buffer, "Stage buffer" },
			u = { gs.undo_stage_hunk, "Undo stage hunk" },
			R = { gs.reset_buffer, "Reset buffer" },
			p = { gs.preview_hunk, "Preview hunk" },
			b = {
				function()
					gs.blame_line({ full = true })
				end,
				"Blame line",
			},
			d = { gs.diffthis, "Diff this" },
			D = {
				function()
					gs.diffthis("~")
				end,
				"Diff",
			},
		},
		["<leader>t"] = {
			name = "+gitsigns toggle",
			b = { gs.toggle_current_line_blame, "Toggle curent line blame" },
			d = { gs.toggle_deleted, "Toggle deleted" },
		},
	})
	wk.register({
		["<leader>h"] = {
			name = "+hunk ops",
			s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
			r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
		},
	}, { mode = "v" })
end

Keybindings = { toggleterm = toggleterm, gitsigns_oa = gitsigns_oa }
