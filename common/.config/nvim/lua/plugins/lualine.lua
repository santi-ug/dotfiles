return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local mode_map = {
      NORMAL = 'N',
      INSERT = 'I',
      VISUAL = 'V',
      ['V-LINE'] = 'VL',
      ['V-BLOCK'] = 'VB',
      COMMAND = 'C',
      REPLACE = 'R',
      ['SELECT'] = 'S',
      ['S-LINE'] = 'SL',
      ['S-BLOCK'] = 'SB',
      TERMINAL = 'T',
    }

    require('lualine').setup {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(mode)
              return mode_map[mode] or mode:sub(1, 1)
            end,
          },
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            path = 1,
            symbols = {
              modified = ' +',
              readonly = ' RO',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
          },
        },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
