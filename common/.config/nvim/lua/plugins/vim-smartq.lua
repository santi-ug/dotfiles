return {
  'marklcrns/vim-smartq',
  init = function()
    vim.g.smartq_default_mappings = 0
  end,
  keys = {
    { '<leader>q', '<Plug>(smartq_this)', mode = 'n', desc = 'Smart quit buffer/window' },
    { '<leader>x', '<Plug>(smartq_this_force)', mode = 'n', desc = 'Force smart quit buffer/window' },
    { '<leader>Q', '<Plug>(smartq_this_save)', mode = 'n', desc = 'Save then smart quit buffer/window' },
    { '<leader>we', '<Plug>(smartq_wipe_empty)', mode = 'n', desc = 'Wipe empty buffers' },
    { '<leader>wc', '<Plug>(smartq_close_splits)', mode = 'n', desc = 'Close extra splits' },
  },
}
