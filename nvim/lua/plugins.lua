return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use("folke/tokyonight.nvim")
	use("nvim-lua/plenary.nvim")
	use("lewis6991/gitsigns.nvim")
	use("unblevable/quick-scope")
	use("rlane/pounce.nvim")
	use("tpope/vim-surround")
	use("jeetsukumaran/vim-indentwise")
	use("sQVe/sort.nvim")
	use("windwp/nvim-autopairs")
	use("folke/which-key.nvim")
	use("b3nj5m1n/kommentary")
	use("Pocco81/AutoSave.nvim")
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"mhartington/formatter.nvim",
		},
	})
	use({
		"p00f/nvim-ts-rainbow",
		requires = {
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
			},
			"wellle/context.vim",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "typescript", "javascript", "php" },
				sync_install = true,
				highlight = { enable = false, additional_vim_regex_highlighting = false },
				rainbow = {
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = 700, -- Do not enable for files with more than n lines, int
				},
			})
		end,
	})
	use({ "ibhagwan/fzf-lua", requires = { "kyazdani42/nvim-web-devicons" } })
	use({
		"nvim-telescope/telescope.nvim",
		disable = true,
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("fzf")
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
	use("rescript-lang/vim-rescript")
end)
