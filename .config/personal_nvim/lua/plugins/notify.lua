return {
  "rcarriga/nvim-notify",
  lazy = false,
  cmd = "Notify",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function() vim.notify = require "notify" end,
}
