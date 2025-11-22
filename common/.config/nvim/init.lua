vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = true

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

vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.undofile = true
-- vim.opt.confirm = true -- confirm quit when unsaving files
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 20

-- [[ Basic Keymaps ]]
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.pumheight = 12
vim.opt.termguicolors = true
vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
    blade = 'blade',
  },
}

-- Personal keymaps
vim.keymap.set('n', '<c-s>', '<cmd>w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'close window current window' })
vim.keymap.set('n', '<C-n>', '<cmd>AdvancedNewFile<CR>', { desc = 'create files and folders using advance new file plugin', noremap = true })
vim.keymap.set('n', '<leader>h', '<cmd>vsplit<CR>', { desc = 'open a new horizontal split with the current buffer' })
vim.keymap.set('n', '<leader>v', '<cmd>split<CR>', { desc = 'open a new vertical split with the current buffer' })
vim.keymap.set('n', '<leader>x', function()
  local buff_name = vim.api.nvim_buf_get_name(0)
  local start = 'term://'
  if string.sub(buff_name, 1, string.len(start)) == start then
    vim.api.nvim_command 'bd!'
  else
    vim.api.nvim_command 'bd'
  end
end, { desc = 'delete the current buffer' })
vim.keymap.set('n', '<leader><Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>tt', '<cmd>terminal<CR>', { desc = 'open a new terminal buffer' })
vim.keymap.set('n', '<leader>to', '<cmd>Oil<CR>', { desc = 'open a new buffer with oil (ls as textfile)' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode', nowait = true })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Tmux left' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Tmux down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Tmux up' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Tmux right' })
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { desc = 'Tmux previous pane' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require('lazy').setup('plugins', {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.api.nvim_set_hl(0, 'Normal', { bg = '#1A1A1E' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1A1A1E' })
