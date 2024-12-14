return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local util = require("config.util")

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
        -- dap.listeners.before.event_terminated.dapui_config = dapui.close
        -- dap.listeners.before.event_exited.dapui_config = dapui.close

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
        vim.keymap.set("n", "<leader>dq", function()
            dap.terminate()
            dapui.close()
        end, { desc = "Terminate debugger" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
        vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
        vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Evaluate expression" })

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
                initCommands = function()
                    -- Find out where to look for the pretty printer Python module
                    local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

                    local script_import = 'command script import "'
                        .. rustc_sysroot
                        .. '/lib/rustlib/etc/lldb_lookup.py"'
                    local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

                    local commands = {}
                    local file = io.open(commands_file, "r")
                    if file then
                        for line in file:lines() do
                            table.insert(commands, line)
                        end
                        file:close()
                    end
                    table.insert(commands, 1, script_import)

                    return commands
                end,
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
                args = function()
                    return util.cli_split(vim.fn.input("CLI arguments: "))
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
