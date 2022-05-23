vim.g.coc_global_extensions = {
	"@yaegassy/coc-intelephense",
	"coc-tsserver",
	"coc-prettier",
	"coc-emmet",
	"coc-html",
	"coc-css",
	"coc-json",
	"coc-marketplace",
	"coc-snippets",
	"coc-sumneko-lua",
	"coc-stylua",
}

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use("folke/tokyonight.nvim")
	use("lewis6991/gitsigns.nvim")
	use("unblevable/quick-scope")
	use("ggandor/lightspeed.nvim")
	use("tpope/vim-surround")
	use("jeetsukumaran/vim-indentwise")
	use("b3nj5m1n/kommentary")
	use("sQVe/sort.nvim")
	use("wellle/context.vim")
	use("windwp/nvim-autopairs")
	use({ "neoclide/coc.nvim", branch = "release" })
	use("folke/which-key.nvim")
	use({
		"fannheyward/telescope-coc.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("coc")
		end,
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lualine/lualine.nvim",
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("lualine").setup({})
			require("neo-tree").setup({
				close_if_last_window = true,
			})
		end,
	})
end)
