local servers =
	{ "sumneko_lua", "rescriptls", "intelephense", "tsserver", "emmet_ls", "zls", "pyright", "nimls", "rust_analyzer" }
--[[ local servers =
	{ "sumneko_lua", "intelephense" } ]]
for _, lsp in pairs(servers) do
	local sttn = { -- default settings
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = Keybinding.lsp_on_attach,
	}
	local spcf = { -- specific settings
		sumneko_lua = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
				},
			},
		},
		rescriptls = {
			cmd = {
				"node",
				"/home/civbag/.local/share/nvim/site/pack/packer/start/vim-rescript/server/out/server.js",
				"--stdio",
			},
		},
	}
	for k, v in pairs(spcf) do
		if lsp ~= k then
			break
		end
		for j, w in pairs(v) do
			sttn[j] = w
		end
	end
	-- vim.pretty_print(sttn)

	require("lspconfig")[lsp].setup(sttn)
end
