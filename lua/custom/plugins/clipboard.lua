return {
  {
    -- 'nvim-lua/plenary.nvim',
    -- config = function()
    --   local in_tmux = vim.env.TMUX ~= nil
    --
    --   if in_tmux then
    --     vim.g.clipboard = {
    --       name = 'tmux',
    --       copy = {
    --         ['+'] = 'tmux load-buffer -',
    --         ['*'] = 'tmux load-buffer -',
    --       },
    --       paste = {
    --         ['+'] = 'tmux save-buffer -',
    --         ['*'] = 'tmux save-buffer -',
    --       },
    --       cache_enabled = false,
    --     }
    --
    --     -- Set up key mappings for easy copying to system clipboard
    --     vim.api.nvim_set_keymap('v', '<C-c>', '"*y :call system("tmux load-buffer -", @*)<CR>', { noremap = true, silent = true })
    --     vim.api.nvim_set_keymap('n', '<C-v>', ':let @*=system("tmux save-buffer -")<CR>"*p', { noremap = true, silent = true })
    --
    --     vim.opt.clipboard = 'unnamedplus'
    --   else
    --     print 'Not in a tmux session. Clipboard configuration not applied.'
    --   end
    -- end,
  },
}
