vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.smartindent = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.scrolloff = 10

vim.cmd([[hi CursorLineNr guifg=#af00af]])

vim.g.mapleader = " "

vim.filetype.add({
    pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/*.conf"] = "bash",
        [".*/hypr/.*%.conf"] = "hyprlang",
        [".*.slang"] = "slang",
    },
})

vim.diagnostic.config({ float = { border = "rounded" } })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    command = "setlocal shiftwidth=2 breakindent linebreak",
})
