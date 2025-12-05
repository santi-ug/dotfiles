return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    require('oil').setup {
      -- Use a floating window
      default_file_explorer = true,

      -- Float configuration
      float = {
        -- Padding around the floating window
        padding = 0,
        max_width = 0, -- 0 means use full width
        max_height = 0, -- 0 means calculate based on window
        border = 'rounded',
        win_options = {
          winblend = 0, -- No transparency, fully opaque
        },
        override = function(conf)
          -- Get editor dimensions
          local height = vim.o.lines
          local width = vim.o.columns

          -- Calculate height (you can adjust this percentage)
          local win_height = math.floor(height * 0.5) -- 80% of screen height
          local win_width = width -- Full width

          -- Center vertically
          local row = math.floor((height - win_height) / 2)
          local col = 0 -- Start from left edge

          conf.row = row
          conf.col = col
          conf.width = win_width
          conf.height = win_height

          return conf
        end,
      },

      -- View options
      view_options = {
        show_hidden = true,
      },

      -- Keymaps
      keymaps = {
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
      },
    }

    -- Set up keybinding to open Oil in float
    vim.keymap.set('n', '-', function()
      require('oil').open_float()
    end, { desc = 'Open Oil in floating window' })
  end,
}
