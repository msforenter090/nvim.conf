M = {
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.pylsp.setup({
            on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                    opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gf", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "gn", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                vim.keymap.set("n", "gb", function() vim.diagnostic.jump({ count = -1 }) end, opts)

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
                        pyflakes = { enabled = false },
                        -- For some reason pycodestyle is the default formatter
                        -- for python-lsp-server; I get formatting errors with pycodestyle
                        -- even when the plugin is turned off.
                        -- I went with this because it is the default.
                        -- Probably should replace it with somethin else in the future.
                        pycodestyle = { enabled = true },
                        pylint = { enabled = false },
                        mccabe = { enabled = false },
                        yapf = { enabled = false },
                        rope_completion = { enabled = false },
                        jedi_completion = { fuzzy = false },
                        jedi_definition = { follow_builtin_imports = false },
                    },
                },
            },
        })
    end,
}

return M
