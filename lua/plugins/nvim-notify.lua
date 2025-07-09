return {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 200,
    config = function()
        local notify = require("notify")
        vim.keymap.set("n", "<leader>n", notify.dismiss, { desc = "Dismiss notifications" })
        vim.notify = notify
    end,
}
