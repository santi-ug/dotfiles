return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = vim.tbl_deep_extend('force', opts.filesystem.filtered_items or {}, {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        hide_ignored = false,
        always_show = {
          '.env',
          '.env.local',
          '.env.development',
          '.env.production',
        },
      })
    end,
    config = function()
      vim.keymap.set('n', '<leader>n', ':Neotree toggle reveal left<CR>', {})
    end,
  },
}
