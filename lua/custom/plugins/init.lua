--  You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufWritePre' }, {
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

-- Always insert spaces when you press <Tab>
vim.o.expandtab   = true
-- Indent width
vim.o.shiftwidth  = 2
-- How many columns a literal <Tab> “looks like”
vim.o.tabstop     = 2
-- How many spaces <BS>/<Tab> insert/remove in insert mode
vim.o.softtabstop = 2

vim.o.spelllang='en_us'
vim.o.spell = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

return {
  {
    -- ruby-slim syntax
    'slim-template/vim-slim',
  },
}
