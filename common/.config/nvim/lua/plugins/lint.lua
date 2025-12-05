return {
  {
    'mfussenegger/nvim-lint',
    init = function()
      require('lint').linters_by_ft = {
        jinja = { 'djlint' },
        ruby = { 'rubocop' },
        typescript = { 'biomejs' },
      }

      vim.api.nvim_create_autocmd('BufWritePost', {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
