require 'laundry.vanilla'
require 'laundry.lazy'

local colorscheme = 'everforest'

require('lazy').setup {
    -- See: https://lazy.folke.io/configuration
    -- Also: https://lazy.folke.io/spec

    checker = {
        enabled = true,

        -- These notifications are very frequent and annoying
        -- TODO: Put them on Lualine
        notify = false,
    },
    install = { colorscheme = { colorscheme } }, -- colorscheme to load during startup installation

    spec = {
        {
            'folke/trouble.nvim',
            cmd = 'Trouble',
            keys = {
                { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>' },
                { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>' },
                { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>' },
                { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>' },
                { '<leader>xL', '<cmd>Trouble loclist toggle<cr>' },
                { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>' },
            },
            opts = {
                warn_no_results = false,
                open_no_results = true,
            },
        },

        {
            'goolord/alpha-nvim',
            config = function()
                local startify = require 'alpha.themes.startify'

                startify.section.header.val = require('laundry.header')

                require('alpha').setup(startify.config)
            end,
            dependencies = { 'nvim-tree/nvim-web-devicons' },
        },

        {
            'kdheepak/lazygit.nvim',
            cmd = {
                -- Plugin lazy-loaded on these commands:
                'LazyGit',
                'LazyGitConfig',
                'LazyGitCurrentFile',
                'LazyGitFilter',
                'LazyGitFilterCurrentFile',
            },
            dependencies = { 'nvim-lua/plenary.nvim' },
            keys = {
                { '<leader>gg', '<cmd>LazyGit<cr>' },
            },
        },

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
            lazy = false,
        },

        {
            -- Display a character as the colorcolumn
            'lukas-reineke/virt-column.nvim',
            config = true,
        },

        -- Completion
        --
        -- I don't need much out of autocompletion, so this section can stay fairly small.
        -- Particularly, as of writing I don't care about snippet or Vim Cmdline completion.
        {
            'hrsh7th/nvim-cmp',
            config = function()
                local cmp = require 'cmp'
                cmp.setup {
                    mapping = {
                        ['<Tab>'] = cmp.mapping.select_next_item(),
                        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                        ['<CR>'] = cmp.mapping.confirm(),
                    },
                    sources = {
                        { name = 'calc' },
                        { name = 'emoji' },
                        { name = 'nvim_lsp' },
                        { name = 'path' },
                    },
                }
            end,
            dependencies = {
                'hrsh7th/cmp-calc',
                'hrsh7th/cmp-emoji',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
            },
        },

        -- LSP
        --
        -- These plugins are very interdependent, and the loading order matters, so I've disabled
        -- lazy-loading for each of them.

        -- Client configuration:
        -- LSPConfig configures the built-in NeoVim LSP client to use different LSP servers.
        {
            'neovim/nvim-lspconfig',
            config = false,
            lazy = false,
        },

        -- Server installation:
        -- Mason installs LSP servers (and other tooling **external** to NeoVim e.g. linters).
        {
            'williamboman/mason.nvim',
            config = true,
            lazy = false,
        },

        -- Mason-LSPConfig
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'neovim/nvim-lspconfig',
                'williamboman/mason.nvim',
            },
            lazy = false,
            opts = {
                -- LSPs configured via LSPConfig should automatically have their servers installed.
                automatic_installation = true,

                handlers = {
                    -- Default handler; by default, LSP client settings are set up for all
                    -- languages.
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            capabilities = require('cmp_nvim_lsp').default_capabilities()
                        }
                    end,
                },
            },
        },
    },
}
