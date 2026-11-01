return {
  -- vim-dadbod plugin
  {
    'tpope/vim-dadbod',
  },
  -- vim-dadbod-ui for UI enhancements
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
  },
  -- vim-dadbod-completion for SQL completion
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
  },
  config = function()
    -- Optional: Keybindings for vim-dadbod-ui
    vim.api.nvim_set_keymap('n', '<leader>du', ':DBUIToggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>df', ':DBUIFindBuffer<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dr', ':DBUIRenameBuffer<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dl', ':DBUILastQueryInfo<CR>', { noremap = true, silent = true })
  end,
}
