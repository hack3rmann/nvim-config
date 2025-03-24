return {
    "folke/noice.nvim",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            hover = { enabled = true },
        },
        presets = {
            -- use a classic bottom cmdline for search
            bottom_search = true,
            -- position the cmdline and popupmenu together
            command_palette = true,
            -- long messages will be sent to a split
            long_message_to_split = true,
            -- enables an input dialog for inc-rename.nvim
            inc_rename = true,
            -- add a border to hover docs and signature help
            lsp_doc_border = true,
        },
        cmdline = { enabled = true },
    },
    config = function(_, opts)
        require("noice").setup(opts)
    end,
}
