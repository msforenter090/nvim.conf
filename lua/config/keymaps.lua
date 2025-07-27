local M = {
    setup = function()
        -- Code formatter.
        vim.keymap.set("n", "<leader>fl", function()
            if vim.bo.filetype == "yaml" or vim.bo.filetype == "lua" then
                require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
            end
            vim.lsp.buf.format()
        end)
    end,
}

return M
