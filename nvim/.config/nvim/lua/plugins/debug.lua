return {
    -- how to use:
    -- 1. compile
    -- 2. toggle breakpoint
    -- 3. `continue` to start (enter args and executable path)
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        -- auto open/close UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- configure lldb backend
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = function()
                    local input = vim.fn.input("Input args: ")
                    return vim.split(input, " ", { trimempty = true })
                end,
            },
        }

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticError", linehl = "", numhl = "" })
        -- vim.fn.sign_define(
        --     "DapBreakpointCondition",
        --     { text = "🟡", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
        -- )
        vim.fn.sign_define(
            "DapStopped",
            { text = "👉", texthl = "DiagnosticInfo", linehl = "CursorLine", numhl = "" }
        )
        dap.configurations.c = dap.configurations.cpp
    end,
    keys = {
        {
            "<leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
        },
        {
            "<leader>c",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
        },
        {
            "<leader>i",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
        },
        {
            "<leader>o",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
        },
        {
            "<leader>u",
            function()
                require("dapui").toggle()
            end,
            desc = "Toggle DAP UI",
        },
    },
}
