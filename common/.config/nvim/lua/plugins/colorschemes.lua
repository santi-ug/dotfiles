return {

  -- Catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  -- TokyoNight
  {
    'folke/tokyonight.nvim',
    priority = 1000,
  },

  -- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    },
  },

  -- OneDark
  {
    'navarasu/onedark.nvim',
    priority = 1000,
  },
}
