return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find file" })
        vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Fuzzy search in files" })
    end,
}
