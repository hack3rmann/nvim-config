return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        local open_debug = function()
            local has_neotree, neotree = pcall(require, "neo-tree.command")

            if has_neotree then
                neotree.execute({
                    action = "close",
                    source = "filesystem",
                })
            end

            dapui.open()
        end

        dap.listeners.before.attach.dapui_config = open_debug
        dap.listeners.before.launch.dapui_config = open_debug
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
        vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate debugger" })
        vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.rust = {
            {
                name = "Rust debug",
                type = "codelldb",
                request = "launch",
                program = function()
                    vim.fn.jobstart("cargo build")
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.c = {
            {
                name = "Debug C",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.cpp = {
            {
                name = "Debug C++",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
    end,
}
