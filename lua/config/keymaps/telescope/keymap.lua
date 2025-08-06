M = {
    setup = function()
        local opts = { noremap = true, silent = true }
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, vim.tbl_extend("force", opts, { desc = "Telescope find files." }))
        vim.keymap.set("n", "<leader>ft", builtin.live_grep, vim.tbl_extend("force", opts, { desc = "Telescopt find text." }))
        vim.keymap.set("n", "<leader>ls", builtin.buffers, vim.tbl_extend("force", opts, { desc = "Telescope list buffers." }))
    end
}

return M
