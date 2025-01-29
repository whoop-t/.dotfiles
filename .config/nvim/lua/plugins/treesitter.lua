return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "dockerfile",
        "bash",
        "html",
        "css",
        "scss",
        "sql",
        "go",
        "markdown",
        "graphql",
        "proto",
      },
      ignore_install = {},
      auto_install = false,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}