return {
  "nvim-pack/nvim-spectre",
  cmd = { "Spectre" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spectre").setup {
      highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
      mapping = {
        -- remap this so <leader>q still quits
        ["send_to_qf"] = {
          map = "<leader>qf",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
      },
    }
  end,
}
