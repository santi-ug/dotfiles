return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,

    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },

    formatters = {
      djlint = {
        args = function()
          return { '--reformat', '-' }
        end,
      },
      biomelint = {
        command = 'node_modules/.bin/biome',
        stdin = true,
        args = function()
          return { 'lint', '--stdin-file-path', '$FILENAME', '--write' }
        end,
      },
    },

    formatters_by_ft = {
      lua = { 'stylua' },

      python = { 'black', 'isort' },

      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },

      typescript = { 'biome', 'biomelint' },
      typescriptreact = { 'prettierd' },

      vue = { 'prettierd' },

      json = { 'biome' },
      jinja = { 'djlint' },
      templ = { 'templ' },
    },
  },
}
