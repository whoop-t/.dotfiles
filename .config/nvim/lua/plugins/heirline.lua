return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil
    opts.tabline = nil
    opts.statusline = {
      status.component.mode(),
      status.component.git_branch {
        -- Fix induvidual components not having transparent bg
        surround = { color = "NONE" },
      },
      status.component.file_info {
        surround = { color = "NONE" },
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
      status.component.diagnostics {
        surround = { color = "NONE" },
      },
      -- status.component.fill(),
      -- status.component.nav(),
      status.component.fill(),
      status.component.lsp {
        padding = { right = 1 },
        surround = { color = "NONE" },
      },
    }

    return opts
  end,
}
