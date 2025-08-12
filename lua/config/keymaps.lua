local M = {
    setup = function()
        -- Code formatter.
        vim.keymap.set("n", "<leader>fl", function()
            if vim.bo.filetype == "yaml" then
                require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
            else
                vim.lsp.buf.format()
            end
        end)
    end,
}

return M
