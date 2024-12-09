return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- JS
        null_ls.builtins.formatting.prettierd.with {
          condition = function(utils)
            return utils.root_has_file(
              ".prettierrc",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.json",
              ".prettierrc.yaml",
              ".prettierrc.yml",
              ".prettierrc.toml",
              "prettier.config.cjs"
            )
          end,
        },
        null_ls.builtins.formatting.biome.with {
          condition = function(utils) return utils.root_has_file "biome.json" end,
        },
      },
    }
  end,
}
