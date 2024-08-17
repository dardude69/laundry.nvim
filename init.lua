-- Require order is important!
require 'laundry.vanilla'
require 'laundry.lazy'

print 'Hello, Laundry Vim!'

local colorscheme = 'habamax'

require('lazy').setup {
    -- See: https://lazy.folke.io/configuration
    -- Also: https://lazy.folke.io/spec

    checker = { enabled = true }, -- automatically check for plugin updates
    install = { colorscheme = { colorscheme } }, -- colorscheme to load during startup installation

    spec = {
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
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
        }
    },
}
