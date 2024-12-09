-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "jsonls",
        "bashls",
        "html",
        "cssls",
        "sqlls",
        "gopls",
        "yamlls",
        "pyright",
        "emmet_language_server",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = {
      ensure_installed = { "prettierd", "stylua", "biome" },
      automatic_installation = false,
      handlers = {
        prettierd = function(source_name, methods)
          -- Conditional to only use prettier when a .pretterrc is in root
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.formatting.prettierd.with {
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
          })
        end,
        eslint = function(source_name, methods)
          -- Conditional to only use eslint when a .eslint is in root
          local null_ls = require "null-ls"
          null_ls.register(require("none-ls.formatting.eslint").with {
            condition = function(utils)
              return utils.root_has_file(
                ".eslintrc",
                ".eslintrc.json",
                ".eslintrc.js",
                ".eslintrc.yml",
                ".eslintrc.yaml"
              )
            end,
          })
        end,
        biome = function(source_name, methods)
          -- Conditional to only use biome when a biome.json is in root
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.formatting.biome.with {
            condition = function(utils) return utils.root_has_file "biome.json" end,
          })
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = { "js", "node2", "chrome" },
    },
  },
}
