return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        local status = require "astronvim.utils.status"

        -- Never build/show tabline
        opts.tabline = {
            condition = false
        }

        opts.statusline = {
            -- statusline
            hl = { fg = "fg", bg = "bg" },
            status.component.mode(),
            status.component.git_branch(),
            status.component.file_info {
                -- Set relative path name
                filename = { modify = ":~:." },
                -- Only show filename when its file, not neotree, telescope, etc
                -- Not sure how to disable for lazygit
                condition = function(self)
                    self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
                    return not status.condition.buffer_matches(
                        { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
                        vim.api.nvim_win_get_buf(self.winid)
                    )
                end,
            },
            status.component.diagnostics(),
            -- status.component.cmd_info(),
            status.component.fill(),
            status.component.lsp(),
            status.component.treesitter(),
            status.component.nav(),
            -- status.component.mode { surround = { separator = "right" } },
        }

        return opts
    end,
}
