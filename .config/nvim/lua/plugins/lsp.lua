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
    -- Remove if you want to go back to nvim-cmp
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require "lspconfig"
      -- If you want to go back to nvim-cmp
      --   local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Set border for shift+k
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      -- Set border for signature help <leader>lh
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- Setup up all language servers that are installed
      for _, value in ipairs(ensure_installed) do
        if value == "ts_ls" then
          lspconfig[value].setup {
            capabilities = capabilities,
            on_attach = function(client, _)
              -- Disable formatting capability for tsserver
              -- This conflicts with other formatters
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          }
        else
          lspconfig[value].setup {
            capabilities = capabilities,
          }
        end
      end

      -- lint/formatters
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#eslint
      -- NOTE: need to install npm install -g vscode-langservers-extracted (eslint globally) for lsp to work
      -- eslint also needs to be installed locally in js/ts project
      -- this is ONLY for eslint projects
      lspconfig.eslint.setup {
        settings = {
          format = false,
        },
      }
      lspconfig.biome.setup {}

      -- key bindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeybindings", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          -- this is mapped in telescope to use telescope picker
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
          vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
          -- using conform now
          -- vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
          --
        end,
      })
    end,
  },
}
