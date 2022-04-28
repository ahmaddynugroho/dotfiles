return require('packer').startup(function(use)
  -- SPEEDUP NEOVIM
  use 'lewis6991/impatient.nvim'

  -- UI STUFF
  use 'ellisonleao/gruvbox.nvim'
  use 'noib3/nvim-cokeline'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup{}
    end
  }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- BUFFER EXPERIENCE
  use 'unblevable/quick-scope'
  use 'ggandor/lightspeed.nvim'
  use 'tpope/vim-surround'
  use 'windwp/nvim-autopairs'
  use 'jeetsukumaran/vim-indentwise'

  -- FUZZY/TREESITTER STUFF
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

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
end)
