return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewFileHistory',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff working tree' },
    { '<leader>gD', '<cmd>DiffviewOpen --cached<CR>', desc = '[G]it [D]iff staged changes' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it file [H]istory' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = '[G]it repo [H]istory' },
    { '<leader>gq', '<cmd>DiffviewClose<CR>', desc = '[G]it close diffview' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = 'diff2_horizontal',
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
      },
    },
    file_panel = {
      listing_style = 'tree',
      tree_options = {
        flatten_dirs = true,
        folder_statuses = 'only_folded',
      },
      win_config = {
        position = 'left',
        width = 35,
      },
    },
    file_history_panel = {
      win_config = {
        position = 'bottom',
        height = 16,
      },
    },
  },
}
