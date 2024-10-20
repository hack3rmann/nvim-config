return {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
        keys = "etovxqpdygfblzhckisuran",
    },
    config = function(_, opts)
        local hop = require("hop")
        hop.setup(opts)

        local Direcion = require("hop.hint").HintDirection

        vim.keymap.set("", "<leader>v", function()
            hop.hint_patterns({ direction = Direcion.ALL, current_line_only = false })
        end, { remap = true, desc = "Hop jump" })
    end,
}
