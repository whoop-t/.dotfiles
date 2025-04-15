return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- only load when opening a markdown file
  config = function()
    require("render-markdown").setup {
      file_types = { "markdown" },
      render_modes = { "n", "v", "V", "i", "c" }, -- render markdown in all modes
      code = {
        sign = false,
        style = "normal",
        width = "block",
      },
    }
  end,
}
