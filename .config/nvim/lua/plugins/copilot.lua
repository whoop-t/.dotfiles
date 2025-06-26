return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  cmd = "Copilot", -- Load on Copilot command usage
  event = "InsertEnter", -- Load when entering insert mode
  config = function()
    require("copilot").setup {
      suggestion = { enabled = true, auto_trigger = true, debounce = 50 },
      panel = { enabled = false },
    }
  end,
  keys = {
    {
      "<leader>ct",
      function()
        require("copilot.suggestion").toggle_auto_trigger()
        local state = vim.b.copilot_suggestion_auto_trigger
        if state then
          vim.notify "Copilot Auto-trigger: ON"
        else
          vim.notify "Copilot Auto-trigger: OFF"
        end
      end,
      mode = "n",
      desc = "Copilot Toggle",
    },
    {
      "<leader>cd",
      function()
        if require("copilot.suggestion").is_visible() then require("copilot.suggestion").dismiss() end
      end,
      mode = "n",
      desc = "Copilot Accept",
    },
    {
      "<Tab>",
      function()
        if require("copilot.suggestion").is_visible() then require("copilot.suggestion").accept() end
      end,
      mode = "i",
      desc = "Copilot Accept",
    },
  },
}
