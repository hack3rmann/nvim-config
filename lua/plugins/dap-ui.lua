return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
    },
    lazy = true,
    config = function(_, opts)
        require("dapui").setup(opts)
    end
}
