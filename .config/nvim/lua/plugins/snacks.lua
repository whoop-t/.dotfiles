return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    bigfile = { enabled = true },
    debug = { enabled = true },
    dim = {
      -- only enable when we toggle it on
      enabled = false,
      animate = {
        -- dont animate
        enabled = false,
      },
    },
    indent = {
      enabled = true,
      animate = {
        enabled = false
      },
      scope = {
        -- Current scope indent highlight with color toggle
        -- dont animate currently
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
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
