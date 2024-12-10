return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
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
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      -- lsp setups
      lspconfig.lua_ls.setup {}
      lspconfig.ts_ls.setup {}

      -- key bindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeybindings", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
          vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
        end,
      })
    end,
  },
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
                ".eslintrc.yaml"
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
                ".eslintrc.yaml"
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
                ".eslintrc.yaml"
              )
            end,
          },
        },
      }
    end,
  },
}
