return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil
    opts.tabline = nil
    opts.statusline = {
      status.component.mode(),
      status.component.git_branch(),
      status.component.file_info {
        -- Set relative path name
        filename = { modify = ":~:." },
        filetype = false,
        -- Only show filename when its file, not neotree, telescope, etc
        condition = function()
          return not status.condition.buffer_matches {
            buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
            filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" },
          }
        end,
      },
      status.component.diagnostics(),
      -- status.component.fill(),
      -- status.component.nav(),
      status.component.fill(),
      status.component.lsp {
        padding = { right = 1 },
      },
    }

    return opts
  end,
}
