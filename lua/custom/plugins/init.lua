-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Strip trailing whitespace on save, keeping the cursor and search history where they were
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('custom-strip-whitespace', { clear = true }),
  pattern = '*',
  callback = function()
    if not vim.bo.modifiable then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.fn.winrestview(view)
  end,
})

-- Always insert spaces when you press <Tab>
vim.o.expandtab = true
-- Indent width
vim.o.shiftwidth = 2
-- How many columns a literal <Tab> "looks like"
vim.o.tabstop = 2
-- How many spaces <BS>/<Tab> insert/remove in insert mode
vim.o.softtabstop = 2

vim.o.spelllang = 'en_us'
vim.o.spell = true

return {}
