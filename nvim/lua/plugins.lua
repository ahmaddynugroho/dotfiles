-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = "init.lua",
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- SPEEDUP NEOVIM
	use("lewis6991/impatient.nvim")

	-- UI STUFF
	use("ellisonleao/gruvbox.nvim")
	use("rebelot/kanagawa.nvim")
	use("folke/tokyonight.nvim")
	use("noib3/nvim-cokeline")
	use("akinsho/toggleterm.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({})
		end,
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})

	-- BUFFER EXPERIENCE
	use("lewis6991/gitsigns.nvim")
	use("unblevable/quick-scope")
	use("ggandor/lightspeed.nvim")
	use("tpope/vim-surround")
	use("windwp/nvim-autopairs")
	use("jeetsukumaran/vim-indentwise")
	use("b3nj5m1n/kommentary")
	use("sQVe/sort.nvim")
    use("wellle/context.vim")

	-- FUZZY/TREESITTER STUFF
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

    -- LSP
    use {'neoclide/coc.nvim', branch = 'release'}
end)
