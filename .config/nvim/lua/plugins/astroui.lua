-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "tokyonight",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- :Telescope then seach "highlights" will show you all the highlights you can alter, good for finding BG to change
        -- Config for transparent bg
        NormalFloat = { bg = "NONE" },
        NormalSB = { bg = "NONE" },
        FloatTitle = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        NormalNC = { bg = "NONE" },
        CursorColumn = { bg = "NONE" },
        CursorLine = { bg = "NONE" },
        CursorLineNr = { bg = "NONE" },
        -- NeoTree(explorer)
        NeoTreeNormal = { bg = "NONE" },
        NeoTreeNormalNC = { bg = "NONE" },
        -- Telescope menus
        TelescopeNormal = { bg = "NONE" },
        TelescopePromptNormal = { bg = "NONE" },
        TelescopePreviewNormal = { bg = "NONE" },
        TelescopeResultsNormal = { bg = "NONE" },
        TelescopeBorder = { bg = "NONE" },
        -- Tabline
        TabLineSel = { bg = "NONE" },
        TabLineFill = { bg = "NONE" },
        -- Bottom status bar
        StatusLine = { bg = "NONE" },
        StatusLineTerm = { bg = "NONE" },
        -- Top Bar
        WinBar = { bg = "NONE" },
        WinBarNC = { bg = "NONE" },
        -- Git Sign Column
        SignColumn = { bg = "NONE" },
        FoldColumn = { bg = "NONE" },
        -- WhichKey preview for commands
        WhichKeyFloat = { bg = "NONE" },
        -- Notify
        NotifyINFOBody = { bg = "NONE" },
        NotifyWARNBody = { bg = "NONE" },
        NotifyERRORBody = { bg = "NONE" },
        NotifyDEBUGBody = { bg = "NONE" },
        NotifyTRACEBody = { bg = "NONE" },
        NotifyINFOBorder = { bg = "NONE" },
        NotifyWARNBorder = { bg = "NONE" },
        NotifyERRORBorder = { bg = "NONE" },
        NotifyDEBUGBorder = { bg = "NONE" },
        NotifyTRACEBorder = { bg = "NONE" },
        NotifyBackground = { bg = "#000000" },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
