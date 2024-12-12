-- NOTE
-- Run :MasonInstall js-debug-adapter
-- This is to manually install the js adapter
-- This was most all generated by chatgpt 💀

local signs = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

return {
  -- nvim-dap for debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI for nvim-dap
      "theHamsta/nvim-dap-virtual-text", -- Inline variable text
      "nvim-neotest/nvim-nio", -- Dependency for dap-ui
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Setup dap-ui
      dapui.setup()

      -- Dap signs
      for name, sign in pairs(signs) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- Auto open/close dap-ui
      dap.listeners.before.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Keybindings
      vim.keymap.set("n", "<leader>da", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

      -- Setup dap-virtual-text
      require("nvim-dap-virtual-text").setup()

      -- Node.js Adapter Configuration
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- JavaScript/Node.js Configuration
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch with npm script",
          runtimeExecutable = "npm",
          -- runtimeArgs = { "start" },
          runtimeArgs = function()
            -- Prompt the user for arguments
            local args = vim.fn.input "Enter npm script arguments (e.g., start): "
            return vim.split(args, "%s+") -- Split the input into a table of arguments
          end,
          cwd = vim.fn.getcwd(),
          console = "integratedTerminal",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
      }
    end,
  },
}
