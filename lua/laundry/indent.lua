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
