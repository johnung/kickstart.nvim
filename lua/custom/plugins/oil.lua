-- lua/custom/plugins/oil.lua
return {
  {
    "stevearc/oil.nvim",
    -- Not recommended to lazy-load: Oil wants to take over directory buffers
    lazy = false,
    -- Optional icon provider (pick ONE)
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }, -- light & fast
      -- "nvim-tree/nvim-web-devicons",        -- or this if you prefer
    },
    opts = {
      -- Make Oil take over when you open directories (e.g. `nvim .`)
      default_file_explorer = true,
      view_options = {
        show_hidden = true, -- show dotfiles (toggle with "g.")
      },
      columns = { "icon" }, -- icons column
    },
    keys = {
      -- like vinegar: open parent directory for current file
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory (Oil)" },
      -- optional: floating file explorer
      { "<leader>o", "<CMD>Oil --float<CR>", desc = "Oil (float)" },
    },
  },
}

