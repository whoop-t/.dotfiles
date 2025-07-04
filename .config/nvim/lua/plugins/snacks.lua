return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      win = {
        -- input window
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-p>"] = { "history_back", mode = { "i", "n" } },
          },
        },
      },
    },
    notifier = { enabled = true },
    bigfile = { enabled = true },
    debug = { enabled = true },
    gitbrowse = { enabled = true },
    dim = {
      -- only enable when we toggle it on
      enabled = false,
      animate = {
        -- dont animate
        enabled = false,
      },
    },
    -- DISABLED CAUSE IM STUMPED
    -- this indent throws errors on nvim 11 when I harpoon to file on first load of nvim
    -- im just using indent-blankline package for now
    -- I cant replicate issue in minimal config either :(
    indent = {
      enabled = false,
      animate = {
        enabled = false,
      },
      scope = {
        -- Current scope indent highlight with color toggle
        -- dont animate currently
        enabled = false,
      },
    },
    lazygit = {
      configure = true,
    },

    --
    -- Snack plugin styles
    --
    styles = {
      lazygit = {
        width = 0.99,
        height = 0.99,
        border = "rounded",
      },
    },
  },
  keys = {
    -- SET UP PICKER FOR SNIPPETS
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippet-list

    -- lazygit
    {
      "<leader>gg",
      function() Snacks.lazygit() end,
      desc = "Lazygit",
    },
    -- notifier
    {
      "<leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss All Notifications",
    },
    -- gitbrowse
    -- CURRENTLY must use gitblame and hover commit hash, then enter command
    {
      "<leader>go",
      function() Snacks.gitbrowse.open { what = "commit" } end,
      desc = "Open commit in browser",
      mode = { "n", "v" },
    },
    -- spell(override default with picker for spelling)
    {
      "z=",
      function() Snacks.picker.spelling() end,
      desc = "Open commit in browser",
      mode = { "n", "v" },
    },
    --
    -- pickers
    --
    -- file: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
    {
      "<leader>fp",
      function() Snacks.picker() end,
      desc = "Find Pickers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files { hidden = true, ignored = true, exclude = { "node_modules", "dist", ".angular" } }
      end,
      desc = "Find Files",
    },
    {
      "<leader>fw",
      function() Snacks.picker.grep { hidden = true, ignored = true, exclude = { "node_modules", "dist", ".angular" } } end,
      desc = "Grep",
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Recent",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.todo_comments { hidden = true, ignored = true, exclude = { "node_modules", "dist", ".angular" } }
      end,
      desc = "Todo",
    },
    -- git
    {
      "<leader>gb",
      function() Snacks.picker.git_branches() end,
      desc = "Git Branches",
    },
    {
      "<leader>gL",
      function() Snacks.picker.git_log() end,
      desc = "Git Log",
    },
    {
      "<leader>gf",
      function() Snacks.picker.git_log_file() end,
      desc = "Git Log File",
    },
    {
      "<leader>gs",
      function() Snacks.picker.git_status() end,
      desc = "Git Status",
    },
    {
      "<leader>gS",
      function() Snacks.picker.git_stash() end,
      desc = "Git Stash",
    },
    {
      "<leader>gd",
      function() Snacks.picker.git_diff() end,
      desc = "Git Diff (Hunks)",
    },
    -- search
    {
      "<leader>sn",
      function() Snacks.notifier.show_history() end,
      desc = "Notification History",
    },
    {
      "<leader>sk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps",
    },
    {
      '<leader>s"',
      function() Snacks.picker.registers() end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function() Snacks.picker.search_history() end,
      desc = "Search History",
    },
    {
      "<leader>sc",
      function() Snacks.picker.command_history() end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function() Snacks.picker.commands() end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function() Snacks.picker.diagnostics_buffer() end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>sD",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "<leader>sh",
      function() Snacks.picker.help() end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function() Snacks.picker.highlights() end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function() Snacks.picker.icons() end,
      desc = "Icons",
    },
    {
      "<leader>sj",
      function() Snacks.picker.jumps() end,
      desc = "Jumps",
    },
    {
      "<leader>sm",
      function() Snacks.picker.marks() end,
      desc = "Marks",
    },
    {
      "<leader>sM",
      function() Snacks.picker.man() end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function() Snacks.picker.lazy() end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>sq",
      function() Snacks.picker.qflist() end,
      desc = "Quickfix List",
    },
    {
      "<leader>su",
      function() Snacks.picker.undo() end,
      desc = "Undo History",
    },
    {
      "<leader>uC",
      function() Snacks.picker.colorschemes() end,
      desc = "Colorschemes",
    },
    {
      "<leader>ss",
      function()
        -- helpful: https://github.com/folke/snacks.nvim/discussions/498
        local snippets = require("luasnip").available()
        local flat_snips = {}
        -- flatten all the snippets into an unnested table
        for _, snips in pairs(snippets) do
          for _, snip in ipairs(snips) do
            table.insert(flat_snips, {
              text = snip.name,
              name = snip.name,
              trigger = snip.trigger,
              description = snip.description,
            })
          end
        end
        -- sort alphabetically
        table.sort(flat_snips, function(a, b) return a.text:lower() < b.text:lower() end)

        -- pipe snippets found into picker
        return Snacks.picker {
          layout = {
            preview = false,
          },
          items = flat_snips,
          -- format the line item text
          format = function(item)
            local desc = type(item.description) == "table" and table.concat(item.description, " ")
              or (item.description or "")

            return {
              { item.name, "SnacksPickerLabel" },
              { " [" .. item.trigger .. "]", "SnacksPickerHint" },
              { " - " .. desc, "SnacksPickerComment" },
            }
          end,
          -- copy trigger for snippet on select
          confirm = function(picker, item)
            picker:close()
            vim.fn.setreg("+", item.trigger) -- copies trigger to clipboard
            vim.notify("Copied trigger: " .. item.trigger)
          end,
        }
      end,
      desc = "Search snippets",
    },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    {
      "<leader>lr",
      function() Snacks.picker.lsp_references() end,
      nowait = true,
      desc = "References",
    },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
        Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
        Snacks.toggle.diagnostics():map "<leader>ud"
        Snacks.toggle.indent():map "<leader>ug"
        Snacks.toggle.dim():map "<leader>uD"
        Snacks.toggle
          .option("laststatus", { off = 0, on = vim.o.laststatus > 0 and vim.o.laststatus or 2 })
          :map "<leader>uS"
      end,
    })
  end,
}
