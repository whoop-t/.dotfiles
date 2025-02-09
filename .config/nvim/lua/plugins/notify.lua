return {
  "rcarriga/nvim-notify",
  lazy = false,
  cmd = "Notify",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local notify = require "notify"

    notify.setup {
      merge_duplicates = true,
      timeout = 2000,
    }

    vim.notify = notify
  end,
}
