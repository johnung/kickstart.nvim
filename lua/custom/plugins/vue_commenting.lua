return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    config = function()
      -- skip loading the old nvim-treesitter module
      vim.g.skip_ts_context_commentstring_module = true

      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "vue", "javascript", "typescript", "css" })
      -- remove the old opts.context_commentstring to avoid triggering the deprecated path
    end,
  },
}

