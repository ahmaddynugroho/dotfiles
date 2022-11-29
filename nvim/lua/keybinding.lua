local set = vim.keymap.set
local wk = require("which-key")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.g.mapleader = " "

set("i", "jk", "<ESC>")
set("i", "kj", "<ESC>")

set("n", [[\]], ":NeoTreeRevealToggle<CR>")

set({ "n", "v" }, "s", ":Pounce<CR>")
set("n", "S", ":PounceRepeat<CR>")
set("o", "s", ":Pounce<CR>")

wk.setup({})
wk.register({
	["<leader>"] = {
		q = { ":q!<CR>", "Force quit" },
		w = { ":w<CR>", "Save" },
		x = { ":bd!<CR>", "Force close buffer" },

		b = { ":FzfLua buffers<CR>", "Buffers" },
		c = { ":FzfLua command_history<CR>", "Command history" },
		f = { ":FzfLua files<CR>", "Files" },
		g = { ":FzfLua live_grep_native<CR>", "Grep live" },
		o = { ":FzfLua oldfiles<CR>", "Recent files" },
		r = { ":FzfLua grep_cword<CR>", "Grep string" },
		["?"] = { ":FzfLua lines<CR>", "Current buffer fzf" },
		["/"] = { ":FzfLua blines<CR>", "Current buffer fzf" },

		s = {
			name = "+set",
			h = { ":set ft=html syn=php<CR>", "ft html" },
			p = { ":set ft=php<CR>", "ft php" },
			c = { ":ContextToggle<CR>", "context.vim" },
			t = { ":TSToggle highlight<CR>", "treesitter highlight" },
		},
	},
})
set("v", "<leader>g", require("fzf-lua").grep_visual, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup({})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		wk.register({
			["<leader>h"] = {
				name = "+hunk operation",
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
					"Diff buffer",
				},
			},
			["<leader>t"] = {
				name = "+hunk toggle",
				b = { gs.toggle_current_line_blame, "Toggle line blame" },
				d = { gs.toggle_deleted, "Toggle deleted" },
			},
		})

		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

local opts = { noremap = true, silent = true }
set("n", "<leader>d", ":FzfLua lsp_document_diagnostics<CR>", opts)
set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

local lsp_on_attach = function(_, bufnr)
	local ob = { noremap = true, silent = true, buffer = bufnr }
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", ob)
	set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", ob)
	set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", ob)
	set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", ob)
	set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ob)
	set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", ob)
	set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", ob)
	set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", ob)
	set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ob)
	set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", ob)
	set("n", "<leader>la", ":FzfLua lsp_code_actions<CR>", ob)
	set("n", "<leader>ls", ":FzfLua lsp_document_symbols<CR>", ob)
	set("n", "<leader>lS", ":FzfLua lsp_workspace_symbols<CR>", ob)
	set("n", "gr", ":FzfLua lsp_references<CR>", ob)
	set("n", "<leader>lf", function()
		vim.cmd([[FormatWrite]])
	end, ob)
	set("n", "<leader>lF", function()
		vim.lsp.buf.formatting()
	end)
	-- set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', ob)
end

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

Keybinding = { lsp_on_attach = lsp_on_attach }
