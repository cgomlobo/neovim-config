return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'udalov/kotlin-vim'

    use 'ThePrimeagen/harpoon'

    use 'tpope/vim-fugitive'

    use 'wuelnerdotexe/vim-astro'

    use 'm4xshen/autoclose.nvim'

    use 'stevearc/conform.nvim'

    use 'lukas-reineke/indent-blankline.nvim'

    use 'HiPhish/rainbow-delimiters.nvim'

    use 'mbbill/undotree'

    use 'mg979/vim-visual-multi'

    use 'tpope/vim-surround'

    use 'terrortylor/nvim-comment'

    use 'Djancyp/better-comments.nvim'

    use 'danymat/neogen'

    use 'airblade/vim-gitgutter'

    use 'levouh/tint.nvim'

    use 'folke/neodev.nvim'

    use 'mfussenegger/nvim-dap'

    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } }

    use 'theHamsta/nvim-dap-virtual-text'

    use 'tpope/vim-sleuth'

    -- Install neovim-remote to support backwards search
    use 'lervag/vimtex'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use 'rmagatti/auto-session'

    use 'nvim-lualine/lualine.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use 'mfussenegger/nvim-jdtls'

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
        'David-Kunz/cmp-npm',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- Themes

    use { 'ku1ik/vim-monokai', as = 'monokai' }

    use { 'rose-pine/neovim', as = 'rose-pine' }

    use { 'Erichain/vim-monokai-pro', as = 'monokai-pro' }

    use { 'morhetz/gruvbox' }

    use { 'yorickpeterse/happy_hacking.vim', as = 'happy-hacking' }

    use { 'catppuccin/nvim', as = 'catppuccin' }
end)
