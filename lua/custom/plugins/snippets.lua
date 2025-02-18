return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.setup {}

    ls.add_snippets('cpp', {
      s('lam', {
        t '[',
        i(1, 'capture'),
        t '](const auto& ',
        i(2, 'obj'),
        t ') {',
        t { '', '\t' },
        i(3, '// code here'),
        t { '', '}' },
      }),

      s('shp', {
        t 'SharedPtr<',
        i(1, 'class'),
        t '> ',
        i(2, 'vname'),
        t ';',
      }),

      s('mshp', {
        t 'auto ',
        i(1, 'vname'),
        t ' = makeShared<',
        i(2, 'class'),
        t '>(',
        i(3, 'params'),
        t ');',
      }),

      s('inc', {
        t '#include "',
        i(1, 'file'),
        t '"',
      }),

      s('usi', {
        t 'using namespace ',
        i(1, 'namespace'),
        t ';',
      }),
    })
  end,
}
