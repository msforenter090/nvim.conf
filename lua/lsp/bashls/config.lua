M = {
    config = function()
        local lspconfig = require("lspconfig")
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

                -- Not supported
                -- vim.keymap.set("n", "empty", vim.lsp.buf.implementation, opts)
                -- vim.keymap.set("n", "empty", vim.lsp.buf.declaration, opts)
                -- vim.keymap.set("n", "empty", vim.lsp.buf.type_definition, opts)

                -- Maybe usefull later
                -- vim.keymap.set("n", "empty", vim.lsp.buf.add_workspace_folder, {})
                -- vim.keymap.set("n", "empty", vim.lsp.buf.remove_workspace_folder, {})
                -- vim.keymap.set("n", "empty", vim.lsp.buf.code_action, opt)
            end,
            flags = {
                debounce_text_changes = 150,
            },
        })
    end,
}

return M
