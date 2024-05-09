--  You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufWritePre' }, {
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.relativenumber = true

return {
  {
    -- ruby-slim syntax
    'slim-template/vim-slim',
  },
}
