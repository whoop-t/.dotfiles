return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  init = function() vim.g.gitblame_enabled = 0 end,
}
