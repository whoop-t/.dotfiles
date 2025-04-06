local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({
    trig = "dcl",
    name = "Debug Console Log",
    dscr = "Debug Console log shortcut",
    autosnippet = true,
  }, {
    t({ 'console.log("##################");', "console.log(" }),
    i(1, ""),
    t({ ");", 'console.log("##################");' }),
  }),
}
