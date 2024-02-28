return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        -- Spell
        null_ls.builtins.completion.spell,
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- JS
        null_ls.builtins.formatting.prettierd.with {
          condition = function(utils)
            return utils.root_has_file(".prettierrc", ".prettierrc.js", ".prettierrc.json", ".prettierrc.yaml")
          end,
        },
      },
    }
  end,
}
