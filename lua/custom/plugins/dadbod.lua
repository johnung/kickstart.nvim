return {
  -- vim-dadbod plugin
  {
    'tpope/vim-dadbod',
  },
  -- vim-dadbod-ui for UI enhancements
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    config = function()
      -- Optional: Keybindings for vim-dadbod-ui
      vim.keymap.set('n', '<leader>du', '<cmd>DBUIToggle<CR>', { desc = '[D]atabase [U]I toggle' })
      vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', { desc = '[D]atabase [F]ind buffer' })
      vim.keymap.set('n', '<leader>dr', '<cmd>DBUIRenameBuffer<CR>', { desc = '[D]atabase [R]ename buffer' })
      vim.keymap.set('n', '<leader>dl', '<cmd>DBUILastQueryInfo<CR>', { desc = '[D]atabase [L]ast query info' })
    end,
  },
  -- vim-dadbod-completion for SQL completion
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
  },
}
