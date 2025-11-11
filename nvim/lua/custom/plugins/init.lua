-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'max397574/better-escape.nvim',
    init = function()
      require('better_escape').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'norcalli/nvim-colorizer.lua',
    init = function()
      require('colorizer').setup()
    end,
  },
  { 'CRAG666/code_runner.nvim', config = true, opts = { filetype = { php = { 'php' } }, { go = { 'go run' } } } },
  {
    'OXY2DEV/markview.nvim',
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      'nvim-treesitter/nvim-treesitter',

      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      preview = {
        modes = { 'n', 'i' },
        hybrid_modes = { 'n', 'i' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    init = function()
      require('lint').linters_by_ft = {
        jinja = { 'djlint' },
        ruby = { 'rubocop' },
        typescript = { 'biomejs' },
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require('lint').try_lint()

          -- You can call `try_lint` with a linter name or a list of names to always
          -- run specific linters, independent of the `linters_by_ft` configuration
          -- require('lint').try_lint 'cspell'
        end,
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      buf_options = {
        buflisted = true,
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  },
  -- {
  --   'luckasRanarison/tailwind-tools.nvim',
  --   name = 'tailwind-tools',
  --   build = ':UpdateRemotePlugins',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-telescope/telescope.nvim', -- optional
  --     'neovim/nvim-lspconfig',         -- optional
  --   },
  --   opts = {},                         -- your configuration
  -- },
  -- {
  --   'github/copilot.vim',
  --   init = function()
  --     vim.keymap.set('i', '<C-{>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false,
  --     })
  --     vim.g.copilot_no_tab_map = true
  --   end,
  -- },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
  --     'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
  --     { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
  --   },
  --   config = true,
  -- },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      require('lualine').setup {}
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    init = function()
      require('treesitter-context').setup {
        max_lines = 4,
        multiline_threshold = 2,
      }
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            [[                                                                              ]],
            [[                                                                              ]],
            [[                                    ██████                                    ]],
            [[                                ████▒▒▒▒▒▒████                                ]],
            [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
            [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
            [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
            [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
            [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
            [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
            [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
            [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
            [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
            [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
            [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
            [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
            [[                        ██      ██      ████      ████                        ]],
            [[                                                                              ]],
          },
          -- Get the current working directory
          footer = { 'current working directory: ', vim.fn.getcwd() },
        },
        shortcut_type = 'number',
        hide = {
          tabline = true,
          winbar = true,
        },
        preview = {
          file_path = true,
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
