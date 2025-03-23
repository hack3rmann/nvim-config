return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    separator = true,
                    text_align = "center",
                },
            },
            hover = {
                enabled = true,
                delay = 20,
                reveal = { "close" },
            },
            diagnostics = "nvim_lsp",
            indicator = {
                style = "underline",
            },
            tab_size = 10,
            max_name_length = 24,
            always_show_bufferline = true,
            numbers = function(opts)
                return string.format("%s", opts.ordinal)
            end,
        },
    },
    config = function(_, opts)
        vim.opt.termguicolors = true
        vim.opt.mousemoveevent = true

        local bufferline = require("bufferline")

        bufferline.setup(opts)

        vim.keymap.set("n", "<leader>tt", ":BufferLinePick<CR>", { desc = "Pick a tab", silent = true })
        vim.keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>", { desc = "Next tab", silent = true })
        vim.keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>", { desc = "Next tab", silent = true })
        vim.keymap.set("n", "<leader>tN", ":BufferLineMoveNext<CR>", { desc = "Next tab", silent = true })
        vim.keymap.set("n", "<leader>tP", ":BufferLineMovePrev<CR>", { desc = "Next tab", silent = true })

        for i = 1, 9 do
            vim.keymap.set("n", string.format("<leader>%d", i), function()
                bufferline.go_to(i, true)
            end, { desc = "Next tab", silent = true })
        end
    end,
}
