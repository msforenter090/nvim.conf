M = {
    setup = function()
        local opts = { noremap = true, silent = true }
        local builtin = require("telescope.builtin")

        -- General
        vim.keymap.set("n", "<leader>ff", builtin.find_files, vim.tbl_extend("force", opts, { desc = "Telescope find files." }))
        vim.keymap.set("n", "<leader>ft", builtin.live_grep, vim.tbl_extend("force", opts, { desc = "Telescopt find text." }))
        vim.keymap.set("n", "<leader>ls", builtin.buffers, vim.tbl_extend("force", opts, { desc = "Telescope list buffers." }))
        vim.keymap.set("n", "<leader>mm", builtin.keymaps, vim.tbl_extend("force", opts, { desc = "Telescope list key mappings." }))
        vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, vim.tbl_extend("force", opts, { desc = "Telescope spell suggest." }))

        -- LSP
        vim.keymap.set("n", "<leader>diag", builtin.diagnostics, vim.tbl_extend("force", opts, { desc = "Telescope diagnostic window." }))
    end
}

return M
