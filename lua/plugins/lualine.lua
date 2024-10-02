return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        return {
            options = {
                theme = "auto",
                globalstatus = true,
            },
            sections = {
                lualine_c = {
                    function()
                        return require("lsp-progress").progress()
                    end,
                },
                lualine_x = { require("action-hints").statusline },
                lualine_y = { require("recorder").displaySlots },
                lualine_z = { require("recorder").recordingStatus },
            },
            extensions = { "neo-tree", "lazy" },
        }
    end,
    config = function(spec, opts)
        local lualine = require "lualine"
        lualine.setup(opts)

        -- listen lsp-progress event and refresh lualine
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = lualine.refresh,
        })
    end,
}
