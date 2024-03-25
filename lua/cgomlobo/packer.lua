return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'ThePrimeagen/harpoon'

    use 'tpope/vim-fugitive'

    use 'wuelnerdotexe/vim-astro'

    use 'm4xshen/autoclose.nvim'

    use 'lukas-reineke/lsp-format.nvim'

    use 'lukas-reineke/indent-blankline.nvim'

    use 'HiPhish/rainbow-delimiters.nvim'

    use 'mbbill/undotree'

    use 'mg979/vim-visual-multi'

    use 'tpope/vim-surround'

    use 'terrortylor/nvim-comment'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

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

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Themes

    use { 'ku1ik/vim-monokai', as = 'monokai' }

    use { 'rose-pine/neovim', as = 'rose-pine' }

    use { 'Erichain/vim-monokai-pro', as = 'monokai-pro' }
end)
