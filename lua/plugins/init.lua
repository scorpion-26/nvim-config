local plugins = {
    -- scheme
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "marko-cerovac/material.nvim",
    },
    {
        "navarasu/onedark.nvim"
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- TS
    {
        'nvim-treesitter/nvim-treesitter',
        config = function() require 'plugins/TS' end
    },

    -- status lines
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            { 'akinsho/bufferline.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
            { 'arkav/lualine-lsp-progress' },
        },
        config = function() require 'plugins/lualine' end,
    },

    {
        'rebelot/heirline.nvim',
        config = function() require 'plugins/heirline' end,
        enabled = false,
    },

    -- better signcolumn
    {
        'luukvbaal/statuscol.nvim',
        config = function() require 'plugins/statuscol' end,
        --enabled = false,
    },

    -- LSP
    {
        'hrsh7th/nvim-cmp',
        config = function() require 'plugins/lsp' end,
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'onsails/lspkind-nvim' }
        }
    },

    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require 'lsp_signature'.setup {
                hint_enable = false
            }
        end
    },

    {
        'folke/neodev.nvim',
        config = function()
            require 'neodev'.setup {}
        end
    },

    -- Make the UI more beautifully
    {
        'stevearc/dressing.nvim',
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require 'ibl'.setup {
                scope = {
                    enabled = false
                }
            }
        end
    },

    {
        'akinsho/toggleterm.nvim',
        config = function()
            require 'toggleterm'.setup({
                size = function(term)
                    if term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    end
                end
            })
        end
    },
    -- Mason
    {
        'williamboman/mason.nvim',
        config = function() require 'mason'.setup() end
    },

    -- autopairs
    {
        'windwp/nvim-autopairs',
        config = function() require 'plugins/autopairs' end
    },

    -- disable lingering hl search
    {
        'romainl/vim-cool'
    },

    -- git integration
    {
        'lewis6991/gitsigns.nvim',
        config = function() require 'gitsigns'.setup {} end,
        dependencies = {
            --'lewis6991/gitsigns.nvim',
            'luukvbaal/statuscol.nvim',
        }
    },

    {
        "mfussenegger/nvim-jdtls",
    },

    {
        "mfussenegger/nvim-dap",
    },

    -- dap
    {
        "rcarriga/nvim-dap-ui",
        config = function() require 'plugins/dap' end,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    {
        "jbyuki/one-small-step-for-vimkind",
        dependencies = { "mfussenegger/nvim-dap" }

    }


    -- TODO: Bufferline, function arguments, debugger
}

return plugins
