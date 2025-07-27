M = {
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.pylsp.setup({
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
                        pylint = { enabled = true },
                        mccabe = { enabled = false },
                        yapf = { enabled = false },
                        rope_completion = { enabled = true },
                        jedi_completion = { fuzzy = true },
                        jedi_definition = { follow_builtin_imports = true },
                    },
                },
            },
        })
    end,
}

return M
