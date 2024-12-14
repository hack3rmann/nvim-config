return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        vim.keymap.set("n", "<leader>n", notify.dismiss, { desc = "Dismiss notifications" })
    end,
}
