return {

  -- Core Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'javascript',
        'html',
        'markdown',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)

      -- Custom parser associations
      vim.treesitter.language.register('htmldjango', 'jinja')
      vim.treesitter.language.register('htmldjango', 'blade')

      -- Custom PHP highlight overrides
      vim.cmd 'hi @function.method.php guifg=#D27E99'
      vim.cmd 'hi @constructor.php guifg=#FFA066'
      vim.cmd 'hi @keyword.function.php guifg=#76946A'
    end,
  },

  -- Treesitter Context (sticky function/class at the top)
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 4,
      multiline_threshold = 2,
    },
  },
}
