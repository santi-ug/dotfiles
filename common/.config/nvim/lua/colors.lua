vim.opt.background = 'dark'
-- vim.cmd.colorscheme 'catppuccin-mocha'

require('userprefs').load_colorscheme()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function(event)
    require('userprefs').save_colorscheme(event.match)
  end,
})
