-- word highlight with other symbols
return {
  "RRethy/vim-illuminate",
  lazy = false, -- need as the keys map make this only load on key press toggle
  config = function() require("illuminate").configure() end,
  keys = {
    -- toggle word highlight
    {
      "<leader>it",
      function() require("illuminate").toggle() end,
      desc = "Toggle word highlight",
    },
  },
}
