-- Vanilla NeoVim Settings

-- Remapping

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set('n', 'gg', '^gg')
vim.keymap.set({'n', 'i'}, '<F1>', '<Nop>') -- Stop opening help with F1

-- LSP Keybinds

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- Disable NetRW

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Colors

vim.opt.termguicolors = true -- Enable 24-bit color

-- Colorcolumn

vim.opt.textwidth = 99
vim.opt.colorcolumn = { '+1' } -- One character ahead of the colorcolumn

-- Gutter

vim.opt.number = true -- Show line numbers
vim.opt.signcolumn = 'yes' -- Always display the sign column to prevent visual jitter

-- Indentation

vim.opt.expandtab = true -- <TAB> inserts spaces
vim.opt.shiftwidth = 4 -- Width of shifting commands (i.e. << and >>)
vim.opt.softtabstop = -1 -- Width of an indentation: -1 means replicate shiftwidth

-- Special handling

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    callback = function()
        -- Two-space indentation for JavaScript
        vim.opt_local.shiftwidth = 2

        -- Suffixes to append to files while searching for them with the "gf" (Goto File) command.
        vim.opt_local.suffixesadd = '.js,.json,.jsx,.mjs,.ts,.tsx'
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'gdscript',
    callback = function()
        -- Indent with tabs -- I started Laundry Game this way like a goober, so I'm just sticking
        -- with it for now.
        vim.opt_local.autoindent = true
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 0 -- Use tabstop
    end,
})
