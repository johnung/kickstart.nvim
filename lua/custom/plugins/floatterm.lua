-- lua/custom/plugins/floatterm.lua
return {
  name = "floatterm-local",
  dir = vim.fn.stdpath("config") .. "/lua",
  lazy = true,
  keys = {
    {
      "<leader>tt",
      function() require("floatterm").toggle() end,
      mode = { "n", "t" },
      desc = "Toggle floating terminal",
    },
  },
  config = function()
    local M = {}
    local state = { win = nil, buf = nil }

    local function win_is_valid() return state.win and vim.api.nvim_win_is_valid(state.win) end
    local function buf_is_valid() return state.buf and vim.api.nvim_buf_is_valid(state.buf) end

    local function set_term_keymaps(buf)
      local opts = { buffer = buf, silent = true }
      -- Easy escape from insert → normal
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
      -- Navigate splits with Ctrl+h/j/k/l
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
      -- Quick close with Ctrl+q
      vim.keymap.set("t", "<C-q>", function() M.close() end, opts)
    end

    local function create_term_buf()
      state.buf = vim.api.nvim_create_buf(false, true)
      vim.bo[state.buf].bufhidden = "hide"

      vim.api.nvim_buf_call(state.buf, function()
        vim.fn.termopen(vim.o.shell, {
          on_exit = function()
            state.win = nil
            state.buf = nil
          end,
        })
      end)

      -- Set buffer-local terminal keymaps
      set_term_keymaps(state.buf)
    end

    local function open_window_for_buf(buf)
      local cols, lines = vim.o.columns, vim.o.lines
      local width  = math.floor(cols * 0.9)
      local height = math.floor(lines * 0.85)
      local row    = math.floor((lines - height) / 2)
      local col    = math.floor((cols - width) / 2)

      state.win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        width = width,
        height = height,
        row = row,
        col = col,
      })

      vim.wo[state.win].number = false
      vim.wo[state.win].relativenumber = false
      vim.wo[state.win].cursorline = false

      vim.cmd.startinsert()
    end

    function M.open()
      if win_is_valid() then return end
      if not buf_is_valid() then create_term_buf() end
      open_window_for_buf(state.buf)
    end

    function M.close()
      if win_is_valid() then
        vim.api.nvim_win_close(state.win, true)
      end
      state.win = nil
    end

    function M.toggle()
      if win_is_valid() then M.close() else M.open() end
    end

    package.loaded["floatterm"] = M
  end,
}

