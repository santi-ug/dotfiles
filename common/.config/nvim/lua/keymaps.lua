-- ============================
-- Keymaps
-- ============================

-- Basic
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<c-s>', '<cmd>w<CR>', { desc = 'Save buffer' })

-- File operations
vim.keymap.set('n', '<C-n>', '<cmd>AdvancedNewFile<CR>', {
  desc = 'Create file/folder (AdvancedNewFile)',
  noremap = true,
})
vim.keymap.set('n', '<leader>h', '<cmd>vsplit<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>v', '<cmd>split<CR>', { desc = 'Vertical split' })

-- Buffer navigation
vim.keymap.set('n', '<leader><Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })

-- Tools
vim.keymap.set('n', '<leader>tt', '<cmd>terminal<CR>', { desc = 'Open terminal buffer' })
vim.keymap.set('n', '<leader>to', '<cmd>Oil<CR>', { desc = 'Open Oil file browser' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Diagnostics → Loclist' })

-- Terminal mode escape
vim.keymap.set('t', 'jj', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
  nowait = true,
})

-- Tmux navigation
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Tmux left' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Tmux down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Tmux up' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Tmux right' })
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { desc = 'Tmux previous pane' })

-- Colorscheme
vim.keymap.set('n', '<leader>tc', function()
  require('telescope.builtin').colorscheme { ignore_builtins = true }
end, {
  desc = 'Change theme',
})

vim.keymap.set('n', '<leader>ts', function()
  require('userprefs').pick_tab_size()
end, {
  desc = 'Change tab size',
})
