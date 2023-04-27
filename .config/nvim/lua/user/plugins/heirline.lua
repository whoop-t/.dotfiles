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
            -- Below is custom filename component that will show filename and 1 dir above
            -- Leaving as comment, incase I want to extend/use later
            -- {
            --     provider = function(self)
            --         local filepath = vim.fn.expand("%:p")
            --         local parentdir = vim.fn.fnamemodify(filepath, ":h:t")
            --         local filename = vim.fn.fnamemodify(filepath, ":t")
            --         return parentdir .. '/' .. filename
            --     end,
            --     condition = function(self)
            --         self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            --         return not status.condition.buffer_matches(
            --             { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
            --             vim.api.nvim_win_get_buf(self.winid)
            --         )
            --     end,
            -- },
            -- Show harpoon index of current buffer if it is marked
            {
                provider = function()
                    local Marked = require("harpoon.mark")
                    local filename = vim.api.nvim_buf_get_name(0)
                    local succuss, index = pcall(Marked.get_index_of, filename)
                    if succuss and index and index > 0 then
                        return "󱡀 " .. index .. " "
                    else
                        return
                    end
                end,
            },
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
            -- status.component.cmd_info(),
            status.component.fill(),
            -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
            -- status.component.lsp(),
            status.component.treesitter(),
            status.component.nav(),
            -- status.component.mode { surround = { separator = "right" } },
        }

        return opts
    end,
}
