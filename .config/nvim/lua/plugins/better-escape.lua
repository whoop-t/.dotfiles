return {
  "max397574/better-escape.nvim",
  event = "VeryLazy",
  opts = {
    timeout = 300,
    default_mappings = false,
    -- Fix lazygit issues
    mappings = {
      i = { j = { k = "<Esc>", j = "<Esc>" } },
    },
  },
}
