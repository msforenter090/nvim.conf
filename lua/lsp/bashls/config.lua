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
}

return M
