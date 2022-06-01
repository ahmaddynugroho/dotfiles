local l = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

l.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = Keybinding.lsp_on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

local servers = { "intelephense", "tsserver", "emmet_ls" }
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		capabilities = capabilities,
		on_attach = Keybinding.lsp_on_attach,
	})
end
