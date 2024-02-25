return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      win_options = {
        -- We need to set transparency to 0 else we will see black BG in certain ui float inputs
        winblend = 0,
      },
    },
  },
}
