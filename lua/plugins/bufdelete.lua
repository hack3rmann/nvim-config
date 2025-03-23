return {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>q",
            function()
                require("bufdelete").bufdelete(0, true)
            end,
            desc = "Close current tab",
        },
    },
}
