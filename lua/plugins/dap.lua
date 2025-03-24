return {
    "mfussenegger/nvim-dap",
    dependencies = { "theHamsta/nvim-dap-virtual-text" },
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle breakpoint",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue debugging",
        },
        {
            "<leader>du",
            function()
                require("dapui").close()
            end,
            desc = "Toggle debug UI",
        },
        {
            "<leader>ds",
            function()
                require("dap").step_over()
            end,
            desc = "Step over",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step into",
        },
        {
            "<leader>do",
            function()
                require("dap").step_out()
            end,
            desc = "Step out",
        },
        {
            "<leader>dq",
            function()
                require("dap").terminate()
                require("dapui").close()
            end,
            desc = "Terminate debugger",
        },
        {
            modes = { "n", "v" },
            "<leader>de",
            function()
                require("dap").eval()
            end,
            desc = "Evaluate expression",
        },
    },
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
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close

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
