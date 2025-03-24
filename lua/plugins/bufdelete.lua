return {
    "famiu/bufdelete.nvim",
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
