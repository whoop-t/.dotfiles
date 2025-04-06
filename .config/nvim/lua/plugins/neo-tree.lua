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
    local icons = require("icons")
    local git_icons = icons.git
    local diagnostics = icons.diagnostics
    -- Set modified highlight color
    vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#c0caf5" })
    -- get autocommand to open neotree on load working
    return {
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
            hint = diagnostics.Hint,
            info = diagnostics.Info,
            warn = diagnostics.Warn,
            error = diagnostics.Error,
          },
        },
        modified = {
          symbol = diagnostics.Modified,
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
            added = git_icons.GitAdd,
            modified = git_icons.GitChange,
            deleted = git_icons.GitDelete,
            renamed = git_icons.GitRenamed,
            -- Status type
            untracked = git_icons.GitUntracked,
            ignored = git_icons.GitIgnored,
            unstaged = git_icons.GitUnstaged,
            staged = git_icons.GitStaged,
            conflict = git_icons.GitConflict,
          },
        },
      },
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
