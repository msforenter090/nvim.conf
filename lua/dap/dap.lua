M = {
    setup = function()

        local dapui = require("dapui")
        local dap = require("dap")
        local dapPython = require("dap-python")

        dapui.setup()
        dapPython.setup(vim.fn.exepath("python"))

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        local opts = { noremap = true, silent = true }

        -- Session management
        -- Start and continue are the same.
        vim.keymap.set("n", "<leader>de", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP Start and continue debugging." }))

        -- Terminate debug session and close dapui
        vim.keymap.set("n", "<leader>dq", function() dap.close() dapui.close() end, vim.tbl_extend("force", opts, { desc = "DAP Terminate debugging." }))

        -- Debugging
        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP Toggle Breakpoint." }))
        vim.keymap.set("n", "<leader>dd", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP Step over." }))
        vim.keymap.set("n", "<leader>ds", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP Stop into." }))
        vim.keymap.set("n", "<leader>da", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP Stop out of." }))
    end
}

return M
