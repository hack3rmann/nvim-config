return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
        inlay_hints = { enabled = false },
        capabilites = {},
        autoformat = false,
        servers = { clangd = {} },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        local lsp_attach = function(client, bufnr)
            K.LspKeymaps(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
        end

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            has_cmp and cmp_nvim_lsp.default_capabilities() or {},
            opts.capabilities or {}
        )

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(opts.servers),
        }

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup {
                    capabilities = capabilities,
                    on_attach = lsp_attach,
                    settings = opts.servers[server_name],
                }
            end,
        })

        lspconfig.clangd.setup {
            cmd = { "/usr/bin/clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            root_dir = lspconfig.util.root_pattern(
                ".clangd",
                ".clang-tidy",
                ".clang-format",
                "compile_commands.json"
            ),
            single_file_support = true,
        }
    end
}
