return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = function()
      return {
        options = {
          icons_enabled = true,
          -- transparent theme
          theme = {
            normal = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
            insert = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
            visual = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
            replace = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
            command = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
            inactive = { a = { bg = "none" }, b = { bg = "none" }, c = { bg = "none" } },
          },
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "aerial",
              "dapui_.",
              "neo-tree",
              "NvimTree",
              "terminal",
              "prompt",
              "nofile",
              "help",
              "quickfix",
              "checkhealth",
            },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            {
              "branch",
              color = { fg = "#bb9af7", gui = "bold" },
            },
            { "filetype", icon_only = true, separator = "", padding = { right = 0, left = 1 } },
            {
              "filename",
              path = 1, -- Show relative path
              symbols = {
                modified = "●", -- Indicator for modified file
                readonly = "", -- Indicator for readonly file
                unnamed = "[No Name]",
              },
              padding = { right = 0, left = 0 },
              fmt = function(str)
                -- Apply ':~:.' modification to the filename
                return vim.fn.fnamemodify(str, ":~:.")
              end,
            },
            { "diagnostics" },
          },
          lualine_c = {},

          lualine_x = {},
          lualine_y = {},

          lualine_z = {
            -- Show lsp and formatter status
            {
              function()
                local buf_clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
                if not buf_clients or vim.tbl_isempty(buf_clients) then return "" end

                local client_names = {}

                -- Check for standard LSP clients
                for _, client in pairs(buf_clients) do
                  if client.name ~= "null-ls" then table.insert(client_names, client.name) end
                end

                -- Check for null-ls sources (formatters)
                local null_ls = require "null-ls"
                local sources = null_ls.get_sources()
                local ft = vim.bo.filetype

                for _, source in ipairs(sources) do
                  if source.filetypes[ft] and source.methods[null_ls.methods.FORMATTING] then
                    table.insert(client_names, source.name)
                  end
                end

                return " " .. table.concat(client_names, ", ")
              end,
              icon = "", -- Gear icon
            },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
