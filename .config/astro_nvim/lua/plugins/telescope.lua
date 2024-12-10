local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local Path = require "plenary.path" -- We use plenary for file path manipulations

local open_in_new_kitty_tab = function(prompt_bufnr)
  local selected_entry = action_state.get_selected_entry()
  local file_path = selected_entry.path or selected_entry.filename

  -- Close the Telescope prompt
  actions.close(prompt_bufnr)

  -- Get the directory of the selected file
  local file_dir = Path:new(file_path):parent():absolute()

  -- Launch a new Kitty tab with the directory set to the file's directory
  -- os.execute("kitty @ launch --type=tab --cwd=" .. file_dir .. ' nvim .')
  os.execute("kitty @ launch --type=tab --cwd=" .. file_dir)
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
          ["<C-t>"] = open_in_new_kitty_tab, -- Map Ctrl+t to open in new Kitty tab
        },
        n = {
          ["<C-t>"] = open_in_new_kitty_tab, -- Normal mode mapping for new Kitty tab
        },
      },
    },
    pickers = {
      find_files = {
        follow = true,
        hidden = true,
        file_ignore_patterns = { ".git/*", "node_modules/*", ".vscode/*" },
      },
    },
  },
}