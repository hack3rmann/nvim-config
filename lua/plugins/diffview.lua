return {
    "sindrets/diffview.nvim",
    keys = {
        {
            "<leader>vd",
            -- TODO: open any file before opening diffview
            ":DiffviewOpen<CR>",
            desc = "View git diff",
        },
        {
            "<leader>vq",
            ":DiffviewClose<CR>",
            desc = "Close git diff",
        },
    },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
    },
}
