-- Swap the p and P to not mess up the clipbard with replaced text
-- but leave the ability to paste the text
vim.keymap.set('x', 'p', 'P', {})
vim.keymap.set('x', 'P', 'p', {})

vim.keymap.set('n', '<leader>cR', '<cmd> ClangdSwitchSourceHeader<CR>', { desc = 'Switch Source/FileHeader C/C++', noremap = true, silent = true })
