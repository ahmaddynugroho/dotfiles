local l = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

l["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = Keybinding.lsp_on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})
l["rescriptls"].setup({
	capabilities = capabilities,
	on_attach = Keybinding.lsp_on_attach,
	cmd = {
		"node",
		"/home/civbag/.local/share/nvim/site/pack/packer/start/vim-rescript/server/out/server.js",
		"--stdio",
	},
})

local servers = { "intelephense", "tsserver", "emmet_ls", "zls", "pyright", "nimls", "rust_analyzer" }
for _, lsp in pairs(servers) do
	l[lsp].setup({
		capabilities = capabilities,
		on_attach = Keybinding.lsp_on_attach,
	})
end
