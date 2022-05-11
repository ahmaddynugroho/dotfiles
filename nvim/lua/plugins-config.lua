-- tabout
require("tabout").setup({})

-- quick-scope
vim.cmd([[highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline]])
vim.cmd([[highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline]])

-- autopairs
require("nvim-autopairs").setup({})

-- kommentary
require("kommentary.config").use_extended_mappings()

-- toggleterm
local terminal_factory = require("toggleterm.terminal").Terminal
require("toggleterm").setup({
	open_mapping = Keybindings.toggleterm,
	direction = "float",
})
Terminal = {
	bash = terminal_factory:new({ start_in_insert = true }),
	lazygit = terminal_factory:new({
		dir = "git_dir",
		cmd = "lazygit",
		hidden = true,
	}),
	nvim = terminal_factory:new({
		dir = "~/dotfiles/nvim/",
		cmd = "nvim",
		hidden = true,
	}),
}

-- lualine
require("lualine").setup({ options = { theme = "tokyonight" } })

-- telescope
require("telescope")
require("telescope").load_extension("fzy_native")

-- lsp-installer
require("nvim-lsp-installer").setup({})

-- tree-sitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"javascript",
		"typescript",
		"go",
		"html",
		"json",
	},
	sync_install = false,
	-- ignore_install = { "javascript" },
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
	},
})

-- nvim-treesitter-context
require("treesitter-context").setup()

-- cokeline
local get_hex = require("cokeline/utils").get_hex
require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
		end,
		bg = "NONE",
	},
	components = {
		{
			text = function(buffer)
				return (buffer.index ~= 1) and "▏" or ""
			end,
			fg = get_hex("Normal", "fg"),
		},
		{
			text = function(buffer)
				return "    " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = function(buffer)
				return buffer.filename .. "    "
			end,
			style = function(buffer)
				return buffer.is_focused and "bold" or nil
			end,
		},
		{ text = "", delete_buffer_on_left_click = true },
		{ text = "  " },
	},
})

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- cmp
vim.cmd([[set completeopt=menu,menuone,noselect]])
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<ESC>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
            -- tabout capabilities
			--[[ elseif has_words_before() then
				cmp.complete() ]]
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
-- ADD capabilities to lspconfig!
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lspconfig
local servers = { "tsserver", "intelephense", "html", "cssls" }
local on_attach = Keybindings.lspconfig_oa
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	})
end

-- sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = runtime_path },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})
