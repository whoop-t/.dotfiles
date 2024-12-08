local ensure_installed = {
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
}

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = ensure_installed,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Set border for shift+k
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      -- Set border for signature help <leader>lh
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })
      -- Set border for diag help <leader>ld
      vim.diagnostic.config {
        float = { border = "rounded" },
      }

      -- Setup up all language servers that are installed
      for _, value in ipairs(ensure_installed) do
        lspconfig[value].setup {
          capabilities = capabilities,
        }
      end

      -- lint/formatters
      lspconfig.eslint.setup {}
      lspconfig.biome.setup {}

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
          -- using conform now
          -- vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)

          -- Show diagnostics with lsp that outputted it
          vim.keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float(nil, {
              border = "rounded",
              -- Customize how each diagnostic is formatted
              format = function(diagnostic)
                if diagnostic.source then
                  return string.format("[%s] %s", diagnostic.source, diagnostic.message)
                else
                  return diagnostic.message
                end
              end,
              header = "", -- Remove the title
            })
          end, { desc = "Show diagnostics with source" })
          --
        end,
      })
    end,
  },
}
