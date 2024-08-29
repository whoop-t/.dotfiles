return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- only load when opening a markdown file
  opts = {
    file_types = { "markdown" },
    render_modes = { "n", "v", "V", "i", "c" }, -- render markdown in all modes
  },
}
