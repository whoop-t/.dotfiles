return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
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

        -- eslint
        require("none-ls.diagnostics.eslint").with {
          condition = function(utils)
            return utils.root_has_file(
              ".eslintrc",
              ".eslintrc.json",
              ".eslintrc.js",
              ".eslintrc.yml",
              ".eslintrc.yaml",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts"
            )
          end,
        },

        require("none-ls.formatting.eslint").with {
          condition = function(utils)
            return utils.root_has_file(
              ".eslintrc",
              ".eslintrc.json",
              ".eslintrc.js",
              ".eslintrc.yml",
              ".eslintrc.yaml",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts"
            )
          end,
        },

        require("none-ls.code_actions.eslint").with {
          condition = function(utils)
            return utils.root_has_file(
              ".eslintrc",
              ".eslintrc.json",
              ".eslintrc.js",
              ".eslintrc.yml",
              ".eslintrc.yaml",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts"
            )
          end,
        },
      },
    }
  end,
}
