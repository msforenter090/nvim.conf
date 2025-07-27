require("config.base")
count = 1
require("config.lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require("mason").setup()
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {},
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Lua & Yaml
                    "stylua",
                    "yamlfmt",

                    -- Bash
                    "bash-language-server",
                    "shellcheck",
                    "shfmt",

                    -- Python
                    "python-lsp-server",
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    yaml = { "yamlfmt" },
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig" },
        },
        config = function()
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")

            lspconfig.pylsp.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    if client:supports_method("textDocument/completion") then
                        vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
                        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
                        vim.keymap.set("i", "<C-Space>", function()
                            vim.lsp.completion.get()
                        end)
                    end
                end,
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = true },
                            pycodestyle = { enabled = true },
                            pylint = { enabled = false },
                            mccabe = { enabled = false },
                            yapf = { enabled = false },
                            rope_completion = { enabled = true },
                            jedi_completion = { fuzzy = true },
                            jedi_definition = { follow_builtin_imports = true },
                        },
                    },
                },
            })

            lspconfig.bashls.setup({
                on_attach = function(client, bufnr)
                    if client:supports_method("textDocument/completion") then
                        vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
                        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
                        vim.keymap.set("i", "<C-Space>", function()
                            vim.lsp.completion.get()
                        end)
                    end
                    -- Keybindings or other per-buffer setup here
                    local opts = { noremap = true, silent = true }
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

                    --                    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                    --                    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
                    --                    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
                    --                    vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
                    --                    -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {})
                    --                    -- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {})
                    --                    -- vim.keymap.set("n", "<leader>wl", function()
                    --                    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    --                    -- end, {})
                    --                    -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
                    --                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
                    --                    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
                    --                    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                    --                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
                    --                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
                    --                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
                    --                    vim.keymap.set("n", "<leader>w", vim.lsp.diagnostic.show_line_diagnost)
                end,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end,
    },
})

require("config.keymaps").setup()
vim.diagnostic.config({ virtual_text = true })
