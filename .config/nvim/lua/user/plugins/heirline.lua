return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

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
        -- Only show filename when its file, not neotree, telescope, etc
        condition = function()
          return not status.condition.buffer_matches {
            buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
            filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" },
          }
        end,
      },
      -- status.component.diagnostics(),
      -- status.component.fill(),
      -- -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      -- status.component.lsp(),
      -- status.component.treesitter(),
      -- status.component.nav(),
    }

    return opts
  end,
}
