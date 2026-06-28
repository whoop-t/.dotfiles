return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- `master` is frozen; `main` is required for nvim 0.12+
  lazy = false, -- the main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
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
      "markdown_inline", -- required by render-markdown.nvim
      "graphql",
      "proto",
      "angular",
      "toml",
    }

    -- Only install parsers that aren't already present (avoids rebuild churn).
    local installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.tbl_filter(
      function(parser) return not vim.tbl_contains(installed, parser) end,
      ensure_installed
    )
    if #to_install > 0 then require("nvim-treesitter").install(to_install) end

    -- The main branch dropped the highlight/indent modules; enable both
    -- per-buffer via a FileType autocmd.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        if pcall(vim.treesitter.start) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
