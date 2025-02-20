return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    bigfile = { enabled = true },
    image = { enabled = true },
    lazygit = {
      configure = true,

    },
    -- picker = { enabled = true },
    styles = {
      lazygit = {
        width = 0.99,
        height = 0.99,
        border = "rounded",
      }
    }
  },
  keys = {
    -- Lazygit
    { "<leader>gg", function() Snacks.lazygit() end,       desc = "Lazygit" },
    -- Notifier
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  }
}
