return {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>tq",
            function()
                require("bufdelete").bufdelete(0, true)
            end,
            desc = "Close current tab",
        },
    },
}
