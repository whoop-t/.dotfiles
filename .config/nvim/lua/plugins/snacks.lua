return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false
      },
      scope = {
        -- Current scope indent highlight with color toggle
        enabled = false
      }
    },
    -- image only works for .png without magick installed
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
    -- lazygit
    { "<leader>gg", function() Snacks.lazygit() end,       desc = "Lazygit" },
    -- notifier
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  }
}
