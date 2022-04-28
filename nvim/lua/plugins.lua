-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                       install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', {clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = 'init.lua'
})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- SPEEDUP NEOVIM
    use 'lewis6991/impatient.nvim'

    -- UI STUFF
    use 'ellisonleao/gruvbox.nvim'
    use 'noib3/nvim-cokeline'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('lualine').setup {} end
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }
    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup() end
    }

    -- BUFFER EXPERIENCE
    use 'unblevable/quick-scope'
    use 'ggandor/lightspeed.nvim'
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    use 'jeetsukumaran/vim-indentwise'

    -- FUZZY/TREESITTER STUFF
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- LSP/COMPLETION STUFF
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'williamboman/nvim-lsp-installer'
    use 'sbdchd/neoformat'
end)
