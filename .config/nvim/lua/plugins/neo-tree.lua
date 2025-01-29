return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- make sure nerd fonts are installed for this to work
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  opts = function()
    local diagnostics = require "diagnostics"
    -- Set modified highlight color
    vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#c0caf5" })
    -- get autocommand to open neotree on load working
    return {
      source_selector = {
        -- having these both false just show normal file path in neo-tree
        winbar = false, -- toggle to show selector on winbar
        statusline = false,
        sources = {
          -- Comment back in if you want sources later
          -- { source = "filesystem" },
          -- { source = "buffers" },
          -- { source = "git_status" },
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
        },
      },
      default_component_configs = {
        diagnostics = {
          symbols = {
            hint = diagnostics.signs.Hint,
            info = diagnostics.signs.Info,
            warn = diagnostics.signs.Warn,
            error = diagnostics.signs.Error,
          },
        },
        modified = {
          symbol = diagnostics.signs.Modified,
          highlight = "NeoTreeModified",
        },
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          indent_size = 2,
          padding = 1,
        },
        -- Below hides the extra info columns
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "", -- this can only be used in the git_status source
            renamed = "➜", -- this can only be used in the git_status source
            -- Status type
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
      system_open = function(state)
        (vim.ui.open or require("astronvim.utils").system_open)(state.tree:get_node():get_id())
      end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      window = {
        mappings = {
          ["q"] = "noop",
          ["<C-f>"] = function() vim.fn.system("tmux neww ~/.config/bin/tmux-sessionizer.sh") end,
        },
      },
    }
  end,
  keys = function()
    return {
      {
        "<leader>e",
        function()
          local bufs = vim.fn.getbufinfo { buflisted = 1 }
          if vim.bo.filetype == "neo-tree" and not bufs[1] then
            -- do nothing
          else
            vim.api.nvim_command "Neotree toggle current reveal_force_cwd"
          end
        end,
      },
    }
  end,
}