local M = {
    setup = function()
        -- Code formatter.
        vim.keymap.set("n", "<leader>fl", function()
            require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
        end)
    end,
}

return M
