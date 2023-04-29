return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        local status = require "astronvim.utils.status"
        local harpoon_components = require "harpoon.heirline"

        opts.winbar = nil
        opts.tabline = nil
        opts.statusline = {
            -- statusline
            hl = { fg = "fg", bg = "bg" },
            status.component.mode(),
            status.component.git_branch(),
            harpoon_components.index,
            status.component.file_info {
                -- Set relative path name
                filename = { modify = ":~:." },
                -- Only show filename when its file, not neotree, telescope, etc
                -- Not sure how to disable for lazygit
                condition = function(self)
                    self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
                    return not status.condition.buffer_matches(
                        {
                            filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" }
                        },
                        vim.api.nvim_win_get_buf(self.winid)
                    )
                end,
            },
            status.component.diagnostics(),
            status.component.fill(),
            -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
            -- status.component.lsp(),
            status.component.treesitter(),
            status.component.nav(),
        }

        return opts
    end,
}
