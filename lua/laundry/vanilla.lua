-- Vanilla NeoVim Settings

-- Remapping

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Disable NetRW

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Colors

vim.opt.termguicolors = true -- Enable 24-bit color

-- Gutter

vim.opt.number = true -- Show line numbers
vim.opt.signcolumn = 'yes' -- Always display the sign column to prevent visual jitter

-- Indentation

vim.opt.expandtab = true -- <TAB> inserts spaces
vim.opt.shiftwidth = 4 -- Width of shifting commands (i.e. << and >>)
vim.opt.softtabstop = -1 -- Width of an indentation: -1 means replicate shiftwidth

-- Two-space indentation for JavaScript
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    callback = function()
        vim.opt_local.shiftwidth = 2
    end,
})
