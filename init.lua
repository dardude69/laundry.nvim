require 'laundry.vanilla'
require 'laundry.lazy'

local colorscheme = 'everforest'

require('lazy').setup {
    -- See: https://lazy.folke.io/configuration
    -- Also: https://lazy.folke.io/spec

    checker = { enabled = true }, -- automatically check for plugin updates
    install = { colorscheme = { colorscheme } }, -- colorscheme to load during startup installation

    spec = {
        {
            'lewis6991/gitsigns.nvim',
            config = true,
        },

        {
            'neanias/everforest-nvim',
            init = function()
                vim.cmd.colorscheme(colorscheme)
            end,
        },

        {
            'nvim-lualine/lualine.nvim',
            config = true,
            dependencies = {
                'neanias/everforest-nvim',
                'nvim-tree/nvim-web-devicons',
            },
        },

        {
            'nvim-telescope/telescope.nvim',
            keys = {
                { '<leader>ff', '<cmd>Telescope find_files<cr>' },
                { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
                { '<C-p>', '<cmd>Telescope git_files<cr>' },
            },
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },

        {
            'nvim-tree/nvim-tree.lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            keys = {
                { '<leader>e', '<cmd>NvimTreeToggle<cr>' },
            },
            lazy = false, -- Disabling lazy loading is recommended
            opts = {},
        },

        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                local configs = require 'nvim-treesitter.configs'
                configs.setup {
                    auto_install = true,
                    highlight = {
                        additional_vim_regex_highlighting = false,
                        enable = true,
                    },
                    -- incremental_selection looks cool, but I don't really understand it
                    indent = { enable = true },
                }
            end,
        },

        {
            'romgrk/barbar.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            keys = {
                { '<A-c>', '<cmd>BufferClose<cr>' },

                { '<A-,>', '<cmd>BufferPrevious<cr>' },
                { '<A-.>', '<cmd>BufferNext<cr>' },

                { '<A-1>', '<cmd>BufferGoto 1<cr>' },
                { '<A-2>', '<cmd>BufferGoto 2<cr>' },
                { '<A-3>', '<cmd>BufferGoto 3<cr>' },
                { '<A-4>', '<cmd>BufferGoto 4<cr>' },
                { '<A-5>', '<cmd>BufferGoto 5<cr>' },
                { '<A-6>', '<cmd>BufferGoto 6<cr>' },
                { '<A-7>', '<cmd>BufferGoto 7<cr>' },
                { '<A-8>', '<cmd>BufferGoto 8<cr>' },
                { '<A-9>', '<cmd>BufferGoto 9<cr>' },
                { '<A-0>', '<cmd>BufferGoto 0<cr>' },
            },
        },

        {
            -- Display a character as the colorcolumn
            'lukas-reineke/virt-column.nvim',
            config = true,
        },

        -- LSP

        {
            -- Mason installs language servers (and other tooling external to
            -- NeoVim -- like linters).

        },
    },
}
