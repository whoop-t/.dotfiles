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
    -- Only allow keybindings in markdown file
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "markdown",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<leader>mt",
          "<CMD>RenderMarkdown toggle<CR>",
          { desc = "Markdown toggle", silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<leader>me",
          "<CMD>RenderMarkdown enable<CR>",
          { desc = "Markdown enable", silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<leader>md",
          "<CMD>RenderMarkdown disable<CR>",
          { desc = "Markdown disable", silent = true }
        )
      end,
    })
  end,
}
