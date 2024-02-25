return {
  "rcarriga/nvim-notify",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function() vim.notify = require "notify" end,
}
