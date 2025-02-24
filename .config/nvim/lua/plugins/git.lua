return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local git_icons = require("icons").git
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>gl", function() gitsigns.blame_line() end, { desc = "View Git blame" })
        end,
        signs = {
          add = { text = git_icons.GitSign },
          change = { text = git_icons.GitSign },
          delete = { text = git_icons.GitSign },
          topdelete = { text = git_icons.GitSign },
          changedelete = { text = git_icons.GitSign },
          untracked = { text = git_icons.GitSign },
        },
      }
    end,
  },
}
