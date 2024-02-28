return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil
    opts.tabline = nil
    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      -- harpoon_components.index, // moved to harpoon2, need to revisit
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
      -- status.component.treesitter(),
      -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      status.component.lsp { padding = { right = 1 } },
    }

    return opts
  end,
}
