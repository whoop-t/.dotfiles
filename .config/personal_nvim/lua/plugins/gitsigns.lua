local git_icons = {
  Git = "󰊢",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitSign = "▎",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
}

return {
  "lewis6991/gitsigns.nvim",
  opts = function()
  return {
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
}
