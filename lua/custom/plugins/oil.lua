return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Make Oil take over when you open directories (e.g. `nvim .`)
    default_file_explorer = true,
    view_options = {
      show_hidden = true, -- show dotfiles (toggle with "g.")
    },
    columns = { 'icon' },
  },
  keys = {
    -- like vinegar: open parent directory for current file
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    { '<leader>o', '<CMD>Oil --float<CR>', desc = '[O]il (float)' },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
