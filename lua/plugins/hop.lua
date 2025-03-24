return {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
        {
            "<leader><leader>",
            function()
                local hop = require("hop")
                local Direction = require("hop.hint").HintDirection;
                hop.hint_patterns({ direction = Direction.ALL, current_line_only = false })
            end,
            remap = true,
            desc = "Hop jump",
        },
    },
    opts = {
        keys = "etovxqpdygfblzhckisuran",
    },
    config = function(_, opts)
        require("hop").setup(opts)
    end,
}
