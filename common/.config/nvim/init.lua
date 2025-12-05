require 'options'
require 'keymaps'
require 'autocmds'
require 'lazynvim'
require 'colors'

-- Yank to system clipboard automatically
vim.keymap.set({ 'n', 'x' }, 'y', '"+y')
vim.keymap.set('n', 'yy', '"+yy')
if vim.env.SSH_CONNECTION then
  vim.o.clipboard = 'unnamedplus'
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg '', '\n'),
      vim.fn.getregtype '',
    }
  end
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
  vim.notify 'SSH detected → using OSC52 for copy, normal paste retained'
end

vim.api.nvim_set_hl(0, 'Normal', { bg = '#1A1A1E' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1A1A1E' })
