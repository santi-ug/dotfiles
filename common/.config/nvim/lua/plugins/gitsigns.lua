return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
    },
    on_attach = function(bufnr)
      local gs = require 'gitsigns'
      local map = function(keys, fn, desc)
        vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = desc })
      end

      map('<leader>gs', gs.stage_hunk, '[G]it [S]tage hunk')
      map('<leader>gS', gs.stage_buffer, '[G]it [S]tage file')
      map('<leader>gu', gs.undo_stage_hunk, '[G]it [U]nstage hunk')
      map('<leader>gU', gs.reset_buffer_index, '[G]it [U]nstage file')
    end,
  },
}
