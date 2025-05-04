local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep

return {
  s({
    trig = "dcl",
    name = "debug Console Log",
    dscr = "debug Console log shortcut",
    autosnippet = true,
  }, {
    t 'console.log("##### ',
    rep(1),
    t ' #####");',
    t { "", "console.log(" },
    i(1),
    t ");",
    t { "", 'console.log("#############");' },
  }),

  s({
    trig = "dcly",
    name = "debug Console Log from yank",
    dscr = "debug Console log from yank shortcut",
    autosnippet = true,
  }, {
    t 'console.log("##### ',
    f(function(_, snip) return snip.env.CLIPBOARD[1] or {} end, {}),
    t ' #####");',
    t { "", "console.log(" },
    f(function(_, snip) return snip.env.CLIPBOARD[1] or {} end, {}),
    t ");",
    t { "", 'console.log("#############");' },
  }),
}
