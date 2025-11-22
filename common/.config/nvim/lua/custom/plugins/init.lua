return {

  { 'CRAG666/code_runner.nvim', config = true, opts = { filetype = { php = { 'php' } }, { go = { 'go run' } } } },
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
          require('lint').try_lint()
        end,
      })
    end,
  },
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
  {
    'nvim-treesitter/nvim-treesitter-context',
    init = function()
      require('treesitter-context').setup {
        max_lines = 4,
        multiline_threshold = 2,
      }
    end,
  },
}
