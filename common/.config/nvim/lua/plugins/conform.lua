return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,

    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = false,
    },

    formatters = {
      djlint = {
        args = function()
          return { '--reformat', '-' }
        end,
      },
      prettierdlint = {
        command = 'node_modules/.bin/prettierd',
        stdin = true,
        args = function()
          return { 'lint', '--stdin-file-path', '$FILENAME', '--write' }
        end,
      },
    },

    formatters_by_ft = {
      lua = { 'stylua' },

      python = { 'black', 'isort' },

      javascript = { 'standard' },
      javascriptreact = { 'standard' },

      -- typescript = { 'prettierd' },
      -- typescriptreact = { 'prettierd' },

      vue = { 'prettierd' },

      json = { 'prettierd' },
      jinja = { 'djlint' },
      templ = { 'templ' },
    },
  },
}
